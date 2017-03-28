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
    
    func setupSettings() {
        self.dataSource = self
        self.delegate = self
        
        self.focusRingType = .none
        self.columnAutoresizingStyle = .uniformColumnAutoresizingStyle
        self.headerView = nil
        
        let column = NSTableColumn(identifier: "test")
        column.resizingMask = .autoresizingMask
        column.sizeToFit()
        
        self.addTableColumn(column)
        self.sizeLastColumnToFit()
    }
    
    func loadHolders() {
        let realm = try! Realm()
        let results = realm.objects(CardHolder.self)
        for holder in results {
            self.holders.append(holder)
        }
        self.reloadData()
    }
}

extension CardHolderTableView: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var result = tableView.make(withIdentifier: "test", owner: nil) as? NSTextField
        
        if result == nil {
            result = NSTextField()
            result!.isBordered = false
            result!.drawsBackground = false
            result!.isBezeled = false
            result!.isEditable = false
            result!.identifier = "test"
        }
        
        return result
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 50
    }
}

extension CardHolderTableView: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.holders.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        let holder = self.holders[row]
        return holder.name
    }
}
