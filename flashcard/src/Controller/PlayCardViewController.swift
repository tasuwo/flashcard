//
//  PlayCardViewController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/25.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

class PlayCardViewController: QuickWindowViewController {
    var resultsView: SearchResultsView!
    var resultViews: [SearchResultView] = []
    var resultInfos: [SearchResultInfo] = []
    var iSelectedResult: Int? = nil
    var shownResultsRange: NSRange? = nil
    
    override class func getDefaultSize() -> NSSize {
        return NSSize(width: 400, height: 300)
    }
    
    class func getResultViewHeight() -> CGFloat {
        return CGFloat(50)
    }
    
    override func loadView() {
        let size = PlayCardViewController.getDefaultSize()
        let view = PlayCardView(frame: NSMakeRect(0, 0, size.width, size.height))
        self.view = view
    }
}
