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

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Calculate window's rect
        var screenSize : CGSize? = nil
        if let screens = NSScreen.screens(),
            let screen  = screens.first {
            screenSize = screen.frame.size
        }

        let winSize = SearchWindowController.winSize
        let winRect: NSRect
        if let scrnSize = screenSize {
            winRect = NSMakeRect(scrnSize.width/2-winSize.width/2, scrnSize.height*2/3, winSize.width, winSize.height)
        } else {
            winRect = NSMakeRect(0, 0, winSize.width, winSize.height)
        }

        self.searchWC = SearchWindowController(window: InputableWindow(contentRect: winRect, styleMask: [.borderless], backing: NSBackingStoreType.buffered, defer: false))
        self.searchWC!.showWindow(self)
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
