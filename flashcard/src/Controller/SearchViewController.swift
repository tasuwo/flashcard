//
//  ViewController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/01.
//  Copyright © 2017 tasuku tozawa. All rights reserved.
//

import Cocoa

class SearchViewController: QuickWindowViewController {
    override class func getDefaultSize() -> NSSize {
        return NSSize(width: 800, height: 50)
    }

    override func loadView() {
        let size = SearchViewController.getDefaultSize()
        let view = SearchView(frame: NSMakeRect(0, 0, size.width, size.height))
        view.delegate = self
        
        self.view = view
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
