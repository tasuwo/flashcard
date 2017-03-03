//
//  AppDelegate.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/01.
//  Copyright © 2017 tasuku tozawa. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    let winSize = NSSize(width: 800, height: 50)
    var win: NSWindow?
    var controller: ViewController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let winRect: NSRect
        if let scrnSize = getScreenSize() {
            winRect = NSMakeRect(scrnSize.width/2-winSize.width/2, scrnSize.height*2/3, winSize.width, winSize.height)
        } else {
            winRect = NSMakeRect(0, 0, winSize.width, winSize.height)
        }

        win = NSWindow(contentRect: winRect, styleMask: NSWindowStyleMask.resizable, backing: NSBackingStoreType.buffered, defer: false)
        controller = ViewController()
        let content = win!.contentView! as NSView
        let view = controller!.view
        content.addSubview(view)
            
        win!.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

