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
        if let holder = realm.objects(CardHolder.self).last {
            return holder.id + 1
        } else {
            return 1
        }
    }
    
    static func lastCards(_ id: Int, realm: Realm) -> List<Card> {
        if let holder = realm.objects(CardHolder.self).filter("id == \(id)").first {
            return holder.cards
        } else {
            return List<Card>()
        }
    }
}

extension CardHolder: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        let realm = try! Realm()
        let holders = realm.objects(CardHolder.self)
        return holders.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        let realm = try! Realm()
        let holder = realm.objects(CardHolder.self).filter("id == \(row)")
        if let h = holder.first {
            return h.name
        }
        return nil
    }
}
