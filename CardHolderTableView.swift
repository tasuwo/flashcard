//
//  CardHolderTableView.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/28.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa
import RealmSwift

class CardHolderTableView: NSTableView {
    var holders = List<CardHolder>()
    open var cardsViewDelegate: CardsViewDelegate?
    
    func setupSettings() {
        self.dataSource = self
        self.delegate = self
        
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
    
    func loadHolders() {
        self.holders = List(CardHolder.all())
        self.reloadData()
    }
}

extension CardHolderTableView: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var result = tableView.make(withIdentifier: "caedHolderCell", owner: nil) as? NSTextField

        if result == nil {
            result = NSTextField()
            result!.isBordered = false
            result!.drawsBackground = false
            result!.isBezeled = false
            result!.isEditable = false
            result!.identifier = "cardHolderCell"
        }

        return result
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        let row = self.selectedRow
        self.cardsViewDelegate?.cardholderSelectionDidChange(row)
    }
    
    func tableView(_ tableView: NSTableView, didAdd rowView: NSTableRowView, forRow row: Int) {
        rowView.backgroundColor = NSColor.init(deviceRed: 239/255, green: 239/255, blue: 239/255, alpha: 1)
    }
}

extension CardHolderTableView: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.holders.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        if let cid = tableColumn?.identifier {
            let holder = self.holders[row]
            switch cid {
            case "id":
                return holder.id
            case "name":
                return holder.name
            default:
                return nil
            }
        }
        return nil
    }
}
