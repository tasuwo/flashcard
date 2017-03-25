//
//  AppDelegate.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/01.
//  Copyright © 2017 tasuku tozawa. All rights reserved.
//

import Cocoa
import RealmSwift

class AppDelegate: NSObject, NSApplicationDelegate {
    var quickWC: QuickWindowController?
    var playWC: PlayCardWindowController?
    var settingsWC: SettingsWindowController?

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
        self.settingsWC = SettingsWindowController(window: NSWindow(contentRect: settingsWinRect, styleMask: [.resizable, .titled], backing: .buffered, defer: false))
        self.playWC = PlayCardWindowController(window: NSWindow(contentRect: playWinRect, styleMask: [.borderless], backing: .buffered, defer: false))
        
        self.quickWC!.showWindow(self)
        self.settingsWC!.showWindow(self)
        self.playWC!.showWindow(self)
        
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
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

class InputableWindow : NSWindow {
    override var canBecomeKey: Bool {
        return true
    }
}
