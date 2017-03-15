//
//  ViewController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/01.
//  Copyright © 2017 tasuku tozawa. All rights reserved.
//

import Cocoa

class SearchViewController: QuickWindowViewController {
    var resultsView: SearchResultsView!
    
    override class func getDefaultSize() -> NSSize {
        return NSSize(width: 800, height: 50)
    }
    
    class func getResultViewHeight() -> CGFloat {
        return CGFloat(50)
    }

    override func loadView() {
        let size = SearchViewController.getDefaultSize()
        let view = SearchView(frame: NSMakeRect(0, 0, size.width, size.height))
        view.delegate = self
        
        self.view = view
        
        resultsView = SearchResultsView(frame: NSMakeRect(0, 0, size.width, 0))
        self.view.addSubview(resultsView)
    }
}

extension SearchViewController {
    func displayResult(_ results: [SearchResultInfo]) {
        let rvHeight = SearchViewController.getResultViewHeight()
        
        // Resize window
        let resultsHeight = rvHeight * CGFloat(results.count)
        let winHeight = resultsHeight + SearchViewController.getDefaultSize().height
        self.delegate?.resize(NSMakeSize(800, winHeight), animate: false)

        // Resize view
        self.resultsView.frame.size = NSMakeSize(800, resultsHeight)
        self.resultsView.layer?.backgroundColor = .black
        
        // Append Views
        var y: CGFloat = 0
        for result in results {
            let view = SearchResultView(frame: NSMakeRect(0, y, 800, rvHeight))
            
            view.setText(result.body)
            if y == 0 {
                view.isSelected = true
            }
            
            self.resultsView.resultViews?.append(view)
            self.resultsView.addSubview(view)
            
            y += rvHeight
        }
    }
}

extension SearchViewController : SearchViewDelegate {
    func didChangeText(_ text: String) {
        self.delegate?.lookup(text)
        
        // Display results to quick window
    }
    
    func didPressEnter() {
        Swift.print("Enter key pressed")
    }
    
    func didMoveUp() {
        Swift.print("Up")
    }
    
    func didMoveDown() {
        Swift.print("Down")
    }
}
