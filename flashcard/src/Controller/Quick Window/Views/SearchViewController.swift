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
    var shownResultsRange: NSRange? = nil
    
    override class func getDefaultSize() -> NSSize {
        return NSSize(width: 800, height: 60)
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
        self.resultInfos = results
        let max: CGFloat = 9
        let nDisplay: CGFloat = CGFloat(results.count) > max ? max : CGFloat(results.count)
        
        clearResults()

        // Resize
        let rvHeight = SearchViewController.getResultViewHeight()
        // Resize view
        let margin: CGFloat = 5
        let resultsHeight = rvHeight * nDisplay + margin
        self.resultsView.frame.size = NSMakeSize(800, resultsHeight)
        // Resize window
        let winHeight = resultsHeight + SearchViewController.getDefaultSize().height
        self.delegate?.resize(NSMakeSize(800, winHeight), animate: false)
        
        // Create views
        for (i, r) in results.enumerated() {
            let v = SearchResultView(frame: NSMakeRect(0, (CGFloat(Int(nDisplay) - i - 1) * rvHeight + margin), 800, rvHeight))
            
            let MAX_STR_LENGTH = 140
            let str = r.body as NSString
            var bodyStr: String = ""
            if str.length > MAX_STR_LENGTH {
                bodyStr = str.substring(to: MAX_STR_LENGTH)
            } else {
                bodyStr = str as String
            }
            v.setText(r.title, bodyStr: bodyStr)
            
            self.resultInfos.append(r)
            self.resultViews.append(v)
            self.resultsView.addSubview(v)
        }

        // Display results
        self.resultViews[0].isSelected = true
        self.iSelectedResult = 0
        shownResultsRange = NSMakeRange(0, Int(nDisplay))
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
        if let i = self.iSelectedResult, self.resultInfos.canAccess(index: i) {
            vc?.targetDefinition = self.resultInfos[self.iSelectedResult!]
        }
    }
    
    func didMoveUp() {
        if let i = self.iSelectedResult, let r = self.shownResultsRange {
            if i > 0 {
                if !r.contain(i-1) {
                    for v in self.resultViews {
                        v.frame.origin.y -= SearchViewController.getResultViewHeight()
                    }
                    shownResultsRange?.location -= 1
                }
                self.resultViews[i].isSelected = false
                self.resultViews[i-1].isSelected = true
                self.iSelectedResult = i-1
            }
        }
    }
    
    func didMoveDown() {
        if let i = self.iSelectedResult, let r = self.shownResultsRange {
            if i < self.resultViews.count-1 {
                if !r.contain(i+1) {
                    for v in self.resultViews {
                        v.frame.origin.y += SearchViewController.getResultViewHeight()
                    }
                    shownResultsRange?.location += 1
                }
                self.resultViews[i].isSelected = false
                self.resultViews[i+1].isSelected = true
                self.iSelectedResult = i+1
            }
        }
    }
    
    func cancel() {
        self.delegate?.cancel()
    }
}
