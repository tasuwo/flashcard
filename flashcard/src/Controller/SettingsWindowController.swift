//
//  SettingsWindowController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/06.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

class SettingsWindowController : NSWindowController {
    static let winSize = NSSize(width: 800, height: 600)
    
    override init(window: NSWindow?) {
        super.init(window: window)
        
        let controller = SettingsViewController()
        let content = self.window!.contentView! as NSView
        let view = controller.view
        content.addSubview(view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.delegate = self
    }
}

// MARK: - NSWindowDelegate
extension SettingsWindowController : NSWindowDelegate {
    func windowDidMiniaturize(_ notification: Notification) {
        print("Window minimized")
    }
    
    func windowWillClose(_ notification: Notification) {
        print("Window closing")
    }
}
