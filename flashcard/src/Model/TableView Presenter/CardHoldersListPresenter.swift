//
//  CardHoldersListPresenter.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/30.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import RealmSwift

protocol CardHolderPresenter: NSTableViewDataSource {
    func load(targetTableView: NSTableView)
    func getHolder(at: Int) -> CardHolder?
}

class CardHolderPresenterImpl: NSObject, CardHolderPresenter {
    fileprivate var holders: Results<CardHolder>?
    private var refreshToken: NotificationToken?

    func load(targetTableView tableView: NSTableView) {
        refreshToken?.stop()
        holders = CardHolder.all()
        refreshToken = holders?.addNotificationBlock({ changes in
            switch changes {
            case .initial:
                tableView.reloadData()
                if let s = AppSettingsImpl.get(), let h = try! CardHolder.get(s.getDefaultHolderId()), let i = self.holders?.index(of: h) {
                    tableView.selectRowIndexes(IndexSet([i]), byExtendingSelection: false)
                }

            case let .update(_, del, ins, upd):
                tableView.beginUpdates()
                tableView.insertRows(at: IndexSet(ins), withAnimation: .slideDown)
                tableView.reloadData(forRowIndexes: IndexSet(upd), columnIndexes: IndexSet(integer: 0))
                tableView.removeRows(at: IndexSet(del), withAnimation: .slideUp)
                tableView.endUpdates()
                if let s = AppSettingsImpl.get(), let h = try! CardHolder.get(s.getDefaultHolderId()), let i = self.holders?.index(of: h) {
                    tableView.selectRowIndexes(IndexSet([i]), byExtendingSelection: false)
                }

            default: break
            }
        })
    }

    func getHolder(at index: Int) -> CardHolder? {
        if let hs = holders,
            index > 0 && index < hs.count {
            return hs[index]
        } else {
            return nil
        }
    }

    deinit {
        refreshToken = nil
    }
}

extension CardHolderPresenterImpl: NSTableViewDataSource {
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
