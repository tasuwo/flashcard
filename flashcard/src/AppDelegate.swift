//
//  AppDelegate.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/01.
//  Copyright © 2017 tasuku tozawa. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    var searchWC: SearchWindowController?
    var settingsWC: SettingsWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Calculate window's rect
        var screenSize : CGSize? = nil
        if let screens = NSScreen.screens(),
            let screen  = screens.first {
            screenSize = screen.frame.size
        }

        let searchWinSize = SearchWindowController.winSize
        let settingsWinSize = SettingsWindowController.winSize
        
        let searchWinRect: NSRect
        let settingsWinRect: NSRect
        
        if let scrnSize = screenSize {
            searchWinRect = NSMakeRect(scrnSize.width/2-searchWinSize.width/2, scrnSize.height*2/3, searchWinSize.width, searchWinSize.height)
            settingsWinRect = NSMakeRect(scrnSize.width/2-settingsWinSize.width/2, scrnSize.height/2-settingsWinSize.height/2, settingsWinSize.width, settingsWinSize.height)
        } else {
            searchWinRect = NSMakeRect(0, 0, searchWinSize.width, searchWinSize.height)
            settingsWinRect = NSMakeRect(0, 0, settingsWinSize.width, settingsWinSize.height)
        }

        self.searchWC = SearchWindowController(window: InputableWindow(contentRect: searchWinRect, styleMask: [.borderless], backing: .buffered, defer: false))
        self.settingsWC = SettingsWindowController(window: NSWindow(contentRect: settingsWinRect, styleMask: [.resizable, .titled], backing: .buffered, defer: false))
        
        self.searchWC!.showWindow(self)
        self.settingsWC!.showWindow(self)
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
