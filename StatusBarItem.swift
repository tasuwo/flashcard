//
//  StatusBarItem.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/25.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

class StatusBarItem: NSObject {
    let WIDTH: CGFloat = 24.4
    let statusItem: NSStatusItem
    
    override init() {
        self.statusItem = NSStatusBar.system().statusItem(withLength: WIDTH)
        
        if let button = statusItem.button {
            let image = NSImage(named: "StatusBarIcon")
            image?.isTemplate = true
            button.image = NSImage(named: "StatusBarIcon")
        }
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Preferences", action: #selector(AppDelegate.didSelectPreferences), keyEquivalent: ","))
        menu.addItem(NSMenuItem(title: "Play", action: #selector(AppDelegate.didSelectPlay), keyEquivalent: "p"))
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.shared().terminate(_:)), keyEquivalent: "q"))
        statusItem.menu = menu
    }
}
