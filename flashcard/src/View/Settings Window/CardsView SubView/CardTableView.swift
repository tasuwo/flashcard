//
//  CardsTableView.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/28.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

class CardTableView: NSTableView {
    func setupSettings() {
        self.focusRingType = .none
        self.rowHeight = 30

        self.columnAutoresizingStyle = .uniformColumnAutoresizingStyle

        let frontColumn = NSTableColumn(identifier: "front")
        let backColumn = NSTableColumn(identifier: "back")
        frontColumn.headerCell.stringValue = "FRONT"
        frontColumn.resizingMask = .autoresizingMask
        frontColumn.sizeToFit()
        backColumn.headerCell.stringValue = "BACK"
        backColumn.resizingMask = .autoresizingMask
        backColumn.sizeToFit()
        self.addTableColumn(frontColumn)
        self.addTableColumn(backColumn)

        self.usesAlternatingRowBackgroundColors = true

        self.sizeLastColumnToFit()
    }
}
