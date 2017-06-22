//
//  CardsListPresenter.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/30.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import Cocoa
import RealmSwift

class CardsListPresenter: NSObject {
    private(set) var cards: Results<Card>?
    private var refreshToken: NotificationToken?

    func loadCards(in holderId: Int, updated: @escaping (RealmCollectionChange<Results<Card>>) -> Void) {
        refreshToken?.stop()
        cards = Card.all(in: holderId)
        refreshToken = cards?.addNotificationBlock(updated)
    }

    func releaseNotificationBlock() {
        refreshToken?.stop()
        refreshToken = nil
    }

    deinit {
        refreshToken = nil
    }
}

extension CardsListPresenter: NSTableViewDataSource {
    func tableView(_ tableView: NSTableView, setObjectValue object: Any?, for tableColumn: NSTableColumn?, row: Int) {
        if let c = cards, let colId = tableColumn?.identifier, let v = object as? String {
            if c.count > row {
                let id = c[row].id
                switch colId {
                case "front":
                    Card.update(id, frontText: v, backText: nil)
                    break
                case "back":
                    Card.update(id, frontText: nil, backText: v)
                    break
                default:
                    return
                }
                // Update height
                tableView.noteHeightOfRows(withIndexesChanged: IndexSet([row]))
            }
            return
        }
    }

    func numberOfRows(in _: NSTableView) -> Int {
        return self.cards?.count ?? 0
    }

    func tableView(_: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        if cards == nil { return nil }
        if tableColumn == nil { return nil }
        if cards!.count > row {
            let card = cards![row]
            switch tableColumn!.identifier {
            case "id":
                return card.id
            case "front":
                return card.frontText
            case "back":
                return card.backText
            default:
                return nil
            }
        }
        return nil
    }
}
