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
    var quickWC: QuickWindowController!
    var playWC: PlayCardWindowController!
    var settingsWC: SettingsWindowController!
    var statusBarController: StatusBarController!

    func applicationDidFinishLaunching(_: Notification) {
        // Calculate window's rect
        let quickWinRect: NSRect
        let settingsWinRect: NSRect
        let playWinRect: NSRect
        if let screens = NSScreen.screens(),
            let screen = screens.first {
            let screenSize = screen.frame.size

            quickWinRect = QuickWindowController.calcRect(screenSize: screenSize)
            settingsWinRect = SettingsWindowController.calcRect(screenSize: screenSize)
            playWinRect = PlayCardWindowController.calcRect(screenSize: screenSize)
        } else {
            quickWinRect = QuickWindowController.defaultRect()
            settingsWinRect = SettingsWindowController.defaultRect()
            playWinRect = PlayCardWindowController.defaultRect()
        }

        self.quickWC = QuickWindowController(window: InputableWindow(
            contentRect: quickWinRect,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false)
        )
        self.settingsWC = SettingsWindowController(window: InputableWindow(
            contentRect: settingsWinRect,
            styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView, .resizable],
            backing: .buffered,
            defer: false)
        )
        self.settingsWC.window?.collectionBehavior = [.fullScreenAuxiliary, .fullScreenPrimary]
        self.playWC = PlayCardWindowController(window: NSKeyDetectableWindow(
            contentRect: playWinRect,
            styleMask: [.titled, .closable],
            backing: .buffered,
            defer: false)
        )

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
            settings.setHotKey()
        }
    }
}

extension AppDelegate {
    func didSelectPreferences() {
        NSApp.activate(ignoringOtherApps: true)
        self.settingsWC?.showWindow(self)
    }

    func togglePlayWindow() {
        if self.playWC!.window!.isVisible {
            self.playWC?.window?.orderOut(self)
        } else {
            NSApp.activate(ignoringOtherApps: true)
            self.playWC?.showWindow(self)
        }
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

class InputableWindow: NSWindow {
    override var canBecomeKey: Bool {
        return true
    }
}
