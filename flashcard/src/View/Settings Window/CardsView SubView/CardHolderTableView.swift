//
//  CardHolderTableView.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/28.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

class CardHolderTableView: NSTableView {
    var presenter: CardHoldersListPresenter? {
        didSet {
            self.dataSource = self.presenter
        }
    }
    open var cardsViewDelegate: CardsViewDelegate?
    
    func setupSettings() {
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
}

extension CardHolderTableView: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var result = tableView.make(withIdentifier: "cardHolderCell", owner: nil) as? NSTextField

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
}

