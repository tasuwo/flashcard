//
//  File.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/11.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

struct SearchResultInfo {
    var title: String
    var body: String
}

protocol SearchResultsViewDelegate {}

class SearchResultsView: NSView {
    open var delegate: SearchResultsViewDelegate?
    var resultViews: [SearchResultView]?

    override init(frame: NSRect) {
        super.init(frame: frame)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
