//
//  ViewController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/01.
//  Copyright © 2017 tasuku tozawa. All rights reserved.
//

import Cocoa

class SearchViewController: NSViewController {
    let defaultSize = NSSize(width: 800, height: 50)
    
    override func loadView() {
        let view = NSView(frame: NSMakeRect(0,0,defaultSize.width,defaultSize.height))
        view.wantsLayer = true
        view.layer?.borderWidth = 2
        view.layer?.borderColor = NSColor.red.cgColor
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        // Change view size to fit with window
        if let winSize = self.view.window?.frame.size {
            self.view.frame = NSMakeRect(0,0,winSize.width,winSize.height)
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}
