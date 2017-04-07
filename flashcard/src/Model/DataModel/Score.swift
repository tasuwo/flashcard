//
//  Score.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/04/07.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Realm
import RealmSwift

class Score: Object {
    dynamic var id = 0
    dynamic var isCorrect: Bool = true
    dynamic var date: NSDate = NSDate()
    let cards = LinkingObjects(fromType: Card.self, property: "scores")
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func lastId() -> Int {
        let realm = try! Realm()
        return realm.objects(Score.self).last?.id ?? -1
    }
    
    convenience init (isCorrect: Bool, date: NSDate) {
        self.init()
        self.id = Score.lastId() + 1
        self.isCorrect = isCorrect
        self.date = date
    }
}

// MARK: - Entity model methods

extension Score {
    static func add(_ score: Score, to card: Card) {
        let realm = try! Realm()
        try! realm.write {
            card.scores.append(score)
            realm.add(card, update: true)
        }
    }
}
