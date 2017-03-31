//
//  Card.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/17.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Realm
import RealmSwift

class Card: Object {
    dynamic var id = 0
    dynamic var frontText = ""
    dynamic var backText = ""
    let cardHolders = LinkingObjects(fromType: CardHolder.self, property: "cards")
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func lastId() -> Int {
        let realm = try! Realm()
        return realm.objects(Card.self).last?.id ?? -1
    }
}

// MARK: - Entity model methods

extension Card {
    static func all(in holderId: Int) -> List<Card>? {
        let realm = try! Realm()
        return realm.objects(CardHolder.self).filter("id == \(holderId)").first?.cards
    }
    
    static func get(_ id: Int) -> Card? {
        let realm = try! Realm()
        return realm.objects(Card.self).filter("id == \(id)").first
    }
    
    static func add(_ card: Card, to holder: CardHolder) {
        holder.cards.append(card)
        let realm = try! Realm()
        try! realm.write {
            realm.add(card)
            realm.add(holder, update: true)
        }
    }
    
    static func add(_ card: Card) {
        let realm = try! Realm()
        try! realm.write {
            if realm.object(ofType: Card.self, forPrimaryKey: card.id) != nil {
                realm.create(Card.self, value: card, update: true)
            } else {
                realm.add(card)
            }
        }
    }
}
