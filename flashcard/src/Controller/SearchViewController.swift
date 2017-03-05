//
//  ViewController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/01.
//  Copyright © 2017 tasuku tozawa. All rights reserved.
//

import Cocoa

class SearchViewController: NSViewController {
    override func loadView() {
        let winSize = SearchWindowController.winSize
        let view = SearchView(frame: NSMakeRect(0,0,winSize.width, winSize.height))
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}
