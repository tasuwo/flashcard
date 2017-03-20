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
    var resultViews: [SearchResultView] = []
    var resultInfos: [SearchResultInfo] = []
    var iSelectedResult: Int? = nil
    
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
        self.clearResults()

        let rvHeight = SearchViewController.getResultViewHeight()
        
        // Resize window
        let max: CGFloat = 9
        var resultsHeight = rvHeight * CGFloat(results.count)
        if CGFloat(results.count) > max {
            resultsHeight = rvHeight * max
        }
        let winHeight = resultsHeight + SearchViewController.getDefaultSize().height
        self.delegate?.resize(NSMakeSize(800, winHeight), animate: false)

        // Resize view
        self.resultsView.frame.size = NSMakeSize(800, resultsHeight)
        self.resultsView.layer?.backgroundColor = .black
        
        // Append Views
        var y: CGFloat = 0
        for result in results {
            let view = SearchResultView(frame: NSMakeRect(0, y * rvHeight, 800, rvHeight))
            
            view.setText(result.body)
            
            self.resultInfos.append(result)
            
            self.resultsView.resultViews?.append(view)
            self.resultsView.addSubview(view)
            self.resultViews.append(view)
            
            y += 1
        }
        
        self.resultViews[Int(y-1)].isSelected = true
        self.iSelectedResult = Int(y-1)
    }
    
    func clearResults() {
        for v in self.resultsView.subviews {
            v.removeFromSuperview()
        }
        self.resultViews = []
        self.resultInfos = []
        self.iSelectedResult = nil
        
        self.delegate?.resize(SearchViewController.getDefaultSize(), animate: false)
    }
}

extension SearchViewController : SearchViewDelegate {
    func didChangeText(_ text: String) {
        self.delegate?.lookup(text)
    }
    
    func didPressEnter() {
        let win = self.view.window
        self.delegate?.transitionTo(.editCard)

        let vc = win?.contentViewController as? EditCardViewController
        vc?.targetDefinition = self.resultInfos[self.iSelectedResult!]
    }
    
    func didMoveUp() {
        if let i = self.iSelectedResult {
            if i < self.resultViews.count-1 {
                self.resultViews[i].isSelected = false
                self.resultViews[i+1].isSelected = true
                self.iSelectedResult = i+1
            }
        }
    }
    
    func didMoveDown() {
        if let i = self.iSelectedResult {
            if i > 0 {
                self.resultViews[i].isSelected = false
                self.resultViews[i-1].isSelected = true
                self.iSelectedResult = i-1
            }
        }
    }
}
