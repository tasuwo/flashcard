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
    private var refreshToken: NotificationToken?

    func load(updated: @escaping (RealmCollectionChange<Results<CardHolder>>) -> Void) {
        refreshToken?.stop()
        holders = CardHolder.all()
        refreshToken = holders?.addNotificationBlock(updated)
    }

    deinit {
        refreshToken = nil
    }
}

extension CardHoldersListPresenter: NSTableViewDataSource {
    func tableView(_ tableView: NSTableView, setObjectValue object: Any?, for _: NSTableColumn?, row: Int) {
        if let h = holders, let v = object as? String {
            if h.count > row {
                let id = h[row].id
                CardHolder.update(id, name: v)
                // Update height
                tableView.noteHeightOfRows(withIndexesChanged: IndexSet([row]))
            }
            return
        }
    }

    func numberOfRows(in _: NSTableView) -> Int {
        return self.holders?.count ?? 0
    }

    func tableView(_: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        if holders == nil { return nil }

        if let cid = tableColumn?.identifier, let h = holders, h.count > row {
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
