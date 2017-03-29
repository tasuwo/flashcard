//
//  CardsTableView.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/28.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa
import RealmSwift

protocol CardTableViewDelegate {
    func cardsTextDidChange(row: Int, ColumnId: String)
}

class CardTableView: NSTableView {
    var cards = List<Card>()
    open var cardTableViewDelegate: CardTableViewDelegate?
    
    func setupSettings() {
        self.dataSource = self
        self.delegate = self
        
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
    
    func loadCards(in holderId: Int) {
        let realm = try! Realm()
        let holders = realm.objects(CardHolder.self).filter("id == \(holderId)")
        if let holder = holders.first {
            self.cards = holder.cards
        }
        self.reloadData()
    }
}

extension CardTableView: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, setObjectValue object: Any?, for tableColumn: NSTableColumn?, row: Int) {
        if let cid = tableColumn?.identifier {
            self.cardTableViewDelegate?.cardsTextDidChange(row: row, ColumnId: cid)
        }
    }
}

extension CardTableView: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.cards.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        let card = cards[row]
        switch tableColumn!.identifier {
        case "front":
            return card.frontText
        case "back":
            return card.backText
        default:
            return nil
        }
    }
}
