//
//  ViewController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/01.
//  Copyright © 2017 tasuku tozawa. All rights reserved.
//

import Cocoa

class SearchViewController: ViewControllerForQuickWindow {
    override func loadView() {
        let winSize = QuickWindowController.winSize
        let view = SearchView(frame: NSMakeRect(0,0,winSize.width, winSize.height))
        view.delegate = self
        
        self.view = view
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

extension SearchViewController : SearchViewDelegate {
    func didChangeText(_ text: String) {
        self.delegate?.lookup(text)
    }
    
    func didPressEnter() {
        Swift.print("Enter key pressed")
    }
}
