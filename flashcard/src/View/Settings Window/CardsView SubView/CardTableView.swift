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
        self.deselectAll(nil)
        self.presenter?.loadCards(in: 0, updated: { changes in
            switch changes {
            case .initial:
                self.reloadData()
                
            case .update(_, let del, let ins, let upd):
                self.beginUpdates()
                self.insertRows(at: IndexSet(ins), withAnimation: .slideDown)
                self.reloadData(forRowIndexes: IndexSet(upd), columnIndexes: IndexSet(integer: 0))
                Swift.print(upd)
                self.removeRows(at: IndexSet(del), withAnimation: .slideUp)
                self.endUpdates()
                
            default: break
            }
        })
    }
}

extension CardTableView: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, dataCellFor tableColumn: NSTableColumn?, row: Int) -> NSCell? {
        let cell = NSCell()
        cell.wraps = true
        cell.isEditable = true
        cell.font = NSFont.systemFont(ofSize: NSFont.systemFontSize())
        if let v = self.dataSource?.tableView?(tableView, objectValueFor: tableColumn, row: row) as? String {
            cell.stringValue = v
            return cell
        }
        return nil
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        if let p = self.presenter, let c = p.cards, row < c.count {
            return Card.calcRowHeight(c[row], tableView: tableView)
        }
        return tableView.rowHeight
    }
}


