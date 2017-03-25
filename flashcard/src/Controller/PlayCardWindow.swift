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
extension PlayCardWindowController : NSWindowDelegate {
    func windowDidMiniaturize(_ notification: Notification) {
        print("Window minimized")
    }
    
    func windowWillClose(_ notification: Notification) {
        print("Window closing")
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
