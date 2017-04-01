//
//  CardsTableView.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/28.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

class CardTableView: NSTableView {
    var presenter: CardsListPresenter? {
        didSet {
            self.dataSource = self.presenter
        }
    }
    open var cardsViewDelegate: CardsViewDelegate?
    
    func setupSettings() {
        self.delegate = self
        
        self.focusRingType = .none
        self.rowHeight = 30
        
        self.columnAutoresizingStyle = .uniformColumnAutoresizingStyle
        
        let idColumn = NSTableColumn(identifier: "id")
        let frontColumn = NSTableColumn(identifier: "front")
        let backColumn = NSTableColumn(identifier: "back")
        idColumn.isHidden = true
        frontColumn.headerCell.stringValue = "FRONT"
        frontColumn.resizingMask = .autoresizingMask
        frontColumn.sizeToFit()
        backColumn.headerCell.stringValue = "BACK"
        backColumn.resizingMask = .autoresizingMask
        backColumn.sizeToFit()
        self.addTableColumn(idColumn)
        self.addTableColumn(frontColumn)
        self.addTableColumn(backColumn)
        
        self.usesAlternatingRowBackgroundColors = true
        
        self.sizeLastColumnToFit()
    }
    
    func loadCards(in holderId: Int) {
        self.presenter?.loadCards(in: holderId)
        self.reloadData()
    }
}

extension CardTableView: NSTableViewDelegate {}
