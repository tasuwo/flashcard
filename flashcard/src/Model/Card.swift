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
    
    static func lastId(_ realm: Realm) -> Int {
        if let user = realm.objects(Card.self).sorted(byKeyPath: "id").last {
            return user.id + 1
        } else {
            return 1
        }
    }
}
