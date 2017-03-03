//
//  SearchWindowController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/03.
//  Copyright © 2017 tasuku tozawa. All rights reserved.
//

import Cocoa

class SearchWindowController : NSWindowController, NSWindowDelegate {
    static let winSize = NSSize(width: 800, height: 50)
    
    override init(window: NSWindow?) {
        super.init(window: window)
        
        let controller = SearchViewController()
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
    
    func windowDidMiniaturize(_ notification: Notification) {
        print("Window minimized")
    }
    
    func windowWillClose(_ notification: Notification) {
        print("Window closing")
    }
}
