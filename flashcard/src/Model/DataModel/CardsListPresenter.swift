//
//  CardsListPresenter.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/30.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import RealmSwift

class CardsListPresenter: NSObject {
    private(set) var cards: List<Card>?
    
    func loadCards(in holderId: Int) {
        cards = Card.all(in: holderId)
    }
}

extension CardsListPresenter: NSTableViewDataSource {
    func tableView(_ tableView: NSTableView, setObjectValue object: Any?, for tableColumn: NSTableColumn?, row: Int) {
        if let c = cards, let colId = tableColumn?.identifier, let v = object as? String {
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
        }
    }

    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.cards?.count ?? 0
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        if cards == nil { return nil }
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
}