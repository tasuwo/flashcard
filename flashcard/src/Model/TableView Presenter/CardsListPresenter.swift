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

protocol CardPresenter: NSTableViewDataSource {
    func load(holderId: Int, targetTableView: NSTableView)
    func releaseNotificationBlock()
    func getCard(at: Int) -> Card?
    func cardsCount() -> Int?
}

class CardPresenterImpl: NSObject, CardPresenter {
    private(set) var cards: Results<Card>?
    private var refreshToken: NotificationToken?

    func loadCards(in holderId: Int, updated: @escaping (RealmCollectionChange<Results<Card>>) -> Void) {
        refreshToken?.stop()
        cards = Card.all(in: holderId)
        refreshToken = cards?.addNotificationBlock(updated)
    }

    func load(holderId: Int, targetTableView: NSTableView) {
        refreshToken?.stop()
        cards = Card.all(in: holderId)
        refreshToken = cards?.addNotificationBlock({ changes in
            switch changes {
            case .initial:
                targetTableView.reloadData()

            case let .update(_, del, ins, upd):
                targetTableView.beginUpdates()
                targetTableView.insertRows(at: IndexSet(ins), withAnimation: .slideDown)
                targetTableView.reloadData(forRowIndexes: IndexSet(upd), columnIndexes: IndexSet(integer: 0))
                targetTableView.removeRows(at: IndexSet(del), withAnimation: .slideUp)
                targetTableView.endUpdates()

            default: break
            }
        })
    }

    func releaseNotificationBlock() {
        refreshToken?.stop()
        refreshToken = nil
    }

    func getCard(at index: Int) -> Card? {
        if let cs = cards,
            index > 0 && index < cs.count {
            return cs[index]
        } else {
            return nil
        }
    }

    func cardsCount() -> Int? {
        return self.cards?.count
    }

    deinit {
        refreshToken = nil
    }
}

extension CardPresenterImpl: NSTableViewDataSource {
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
