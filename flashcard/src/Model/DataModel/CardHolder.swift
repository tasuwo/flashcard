//
//  CardHolder.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/17.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Realm
import RealmSwift

class CardHolder: Object {
    dynamic var id = 0
    dynamic var name = ""
    let cards = List<Card>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func lastId() -> Int {
        let realm = try! Realm()
        return realm.objects(CardHolder.self).last?.id ?? -1
    }
    
    convenience init (name: String) {
        self.init()
        self.id = CardHolder.lastId() + 1
        self.name = name
    }
}

// MARK: - Entity model methods

extension CardHolder {
    static func all() -> Results<CardHolder> {
        let realm = try! Realm()
        return realm.objects(CardHolder.self)
    }

    static func get(_ id: Int) -> CardHolder? {
        let realm = try! Realm()
        return realm.objects(CardHolder.self).filter("id == \(id)").first
    }
    
    static func add(_ holder: CardHolder) {
        let realm = try! Realm()
        try! realm.write {
            if realm.object(ofType: CardHolder.self, forPrimaryKey: holder.id) != nil {
                realm.create(CardHolder.self, value: holder, update: true)
            } else {
                realm.add(holder)
            }
        }
    }
    
    static func update(_ id: Int, name: String) {
        let realm = try! Realm()
        if let holder = CardHolder.get(id) {
            try! realm.write {
                holder.name = name
                realm.create(CardHolder.self, value: holder, update: true)
            }
        }
    }
    
    static func delete(_ holder: CardHolder) {
        let realm = try! Realm()
        try! realm.write {
            for c in holder.cards {
                realm.delete(c)
            }
            realm.delete(holder)
        }
    }
}
