//
//  CardHolderTableView.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/28.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

class CardHolderTableView: NSTableView {
    func setupSettings() {
        self.rowHeight = 50
        self.backgroundColor = NSColor.init(deviceRed: 239/255, green: 239/255, blue: 239/255, alpha: 1)
        
        self.focusRingType = .none
        self.columnAutoresizingStyle = .uniformColumnAutoresizingStyle
        self.headerView = nil
        
        let idColumn = NSTableColumn(identifier: "id")
        idColumn.isHidden = true
        self.addTableColumn(idColumn)
        let column = NSTableColumn(identifier: "name")
        column.resizingMask = .autoresizingMask
        column.sizeToFit()
        self.addTableColumn(column)

        self.sizeLastColumnToFit()
    }
}


