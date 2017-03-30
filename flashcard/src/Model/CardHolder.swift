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
    
    static func lastId(_ realm: Realm) -> Int {
        let realm = try! Realm()
        return realm.objects(CardHolder.self).last?.id ?? -1
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
}
