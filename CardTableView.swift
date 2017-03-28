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
    func selectionDidChange()
}

class CardTableView: NSTableView {
    var cards = List<Card>()
    
    func setupSettings() {
        self.dataSource = self
        self.delegate = self
        
        self.focusRingType = .none
        
        self.columnAutoresizingStyle = .uniformColumnAutoresizingStyle
        
        let frontColumn = NSTableColumn(identifier: "front")
        let backColumn = NSTableColumn(identifier: "back")
        frontColumn.headerCell.stringValue = "FRONT"
        backColumn.headerCell.stringValue = "BACK"
        self.addTableColumn(frontColumn)
        self.addTableColumn(backColumn)
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
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var result = tableView.make(withIdentifier: "cardCel", owner: nil) as? NSTextField
        
        if result == nil {
            result = NSTextField()
            result!.isBordered = false
            result!.drawsBackground = false
            result!.isBezeled = false
            result!.isEditable = false
            result!.identifier = "cardCell"
        }
        
        return result
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
