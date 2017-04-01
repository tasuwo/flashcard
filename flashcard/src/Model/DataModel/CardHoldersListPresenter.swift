//
//  CardHoldersListPresenter.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/30.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import RealmSwift

class CardHoldersListPresenter: NSObject {
    private(set) var holders: Results<CardHolder>?
    
    func load() {
        holders = CardHolder.all()
    }
}

extension CardHoldersListPresenter: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.holders?.count ?? 0
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        if holders == nil { return nil }
        if let cid = tableColumn?.identifier {
            let holder = holders![row]
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
