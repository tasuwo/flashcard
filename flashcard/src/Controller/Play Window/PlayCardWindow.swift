//
//  PlayCardWindow.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/25.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa


class PlayCardWindowController : NSWindowController {

    override init(window: NSWindow?) {
        super.init(window: window)
        
        let vc = PlayCardViewController()
        self.window!.contentViewController = vc
        self.window?.hasShadow = true
        self.window?.titleVisibility = .hidden
        self.window?.titlebarAppearsTransparent = true
        self.window?.delegate = self
        self.window?.styleMask.insert(.fullSizeContentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.titleVisibility = .hidden
    }
}

// MARK: - NSWindowDelegate
extension PlayCardWindowController : NSWindowDelegate {
    func windowDidMiniaturize(_ notification: Notification) {
        print("Window minimized")
    }
    
    func windowWillClose(_ notification: Notification) {
        print("Window closing")
    }
    
    func windowDidResignKey(_ notification: Notification) {
        self.window?.orderOut(self)
    }
}

class KeyDetectableBorderlessWindow: NSWindow {
    override var canBecomeMain: Bool {
        get { return true }
    }
    
    override var canBecomeKey: Bool {
        get { return true }
    }
}
