//
//  AppDelegate.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/01.
//  Copyright © 2017 tasuku tozawa. All rights reserved.
//

import Cocoa
import RealmSwift
import Magnet

class AppDelegate: NSObject, NSApplicationDelegate {
    var quickWC: QuickWindowController?
    var playWC: PlayCardWindowController?
    var settingsWC: SettingsWindowController?
    var statusBarController: StatusBarController!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Calculate window's rect
        var screenSize : CGSize? = nil
        if let screens = NSScreen.screens(),
            let screen  = screens.first {
            screenSize = screen.frame.size
        }

        // TODO: Size setting for window
        let quickWinSize = SearchViewController.getDefaultSize()
        let settingsWinSize = SettingsWindowController.winSize
        let playWinSize = PlayCardViewController.getDefaultSize()
        
        let quickWinRect: NSRect
        let settingsWinRect: NSRect
        let playWinRect: NSRect
        
        if let scrnSize = screenSize {
            quickWinRect = NSMakeRect(scrnSize.width/2-quickWinSize.width/2, scrnSize.height*2/3, quickWinSize.width, quickWinSize.height)
            settingsWinRect = NSMakeRect(scrnSize.width/2-settingsWinSize.width/2, scrnSize.height/2-settingsWinSize.height/2, settingsWinSize.width, settingsWinSize.height)
            playWinRect = NSMakeRect(scrnSize.width/2-playWinSize.width/2, scrnSize.height/2-playWinSize.height/2, playWinSize.width, playWinSize.height)
        } else {
            quickWinRect = NSMakeRect(0, 0, quickWinSize.width, quickWinSize.height)
            settingsWinRect = NSMakeRect(0, 0, settingsWinSize.width, settingsWinSize.height)
            playWinRect = NSMakeRect(0, 0, playWinSize.width, playWinSize.height)
        }

        self.quickWC = QuickWindowController(window: InputableWindow(contentRect: quickWinRect, styleMask: [.borderless], backing: .buffered, defer: false))
        self.settingsWC = SettingsWindowController(window: InputableWindow(contentRect: settingsWinRect, styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView, .resizable], backing: .buffered, defer: false))
        self.settingsWC?.window?.collectionBehavior = [ .fullScreenAuxiliary, .fullScreenPrimary ]
        self.playWC = PlayCardWindowController(window: KeyDetectableBorderlessWindow(contentRect: playWinRect, styleMask: [.borderless], backing: .buffered, defer: false))
        
        // Initialize database
        let realm = try! Realm()
        let defaultHolder = realm.objects(CardHolder.self).filter("id == 0")
        if defaultHolder.count == 0 {
            let cardHolder = CardHolder()
            cardHolder.id = 0
            cardHolder.name = "default"
            try! realm.write {
                realm.add(cardHolder)
            }
        }
        
        // Initialize Status bar
        self.statusBarController = StatusBarController()
        
        // Load App Setttings
        if let settings = AppSettings.get() {
            HotKeyCenter.shared.unregisterHotKey(with: "KeyHolderExample")
            let hotKey = HotKey(identifier: "KeyHolderExample", keyCombo: settings.keyCombo, target: self, action: #selector(AppDelegate.toggleQuickWindow))
            hotKey.register()
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

extension AppDelegate {
    func didSelectPreferences() {
        NSApp.activate(ignoringOtherApps: true)
        self.settingsWC?.showWindow(self)
    }
    
    func toggleQuickWindow() {
        if self.quickWC!.window!.isVisible {
            self.quickWC?.window?.orderOut(self)
        } else {
            NSApp.activate(ignoringOtherApps: true)
            self.quickWC?.showWindow(self)
        }
    }
}

class InputableWindow : NSWindow {
    override var canBecomeKey: Bool {
        return true
    }
}
