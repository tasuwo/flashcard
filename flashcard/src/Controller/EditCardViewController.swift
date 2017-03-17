//
//  EditCardViewController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/10.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa
import RealmSwift

class EditCardViewController: QuickWindowViewController {
    var targetDefinition: SearchResultInfo? = nil {
        didSet {
            let view = self.view as? EditCardView
            view?.definition = self.targetDefinition!.body
        }
    }
    var cardText: (String, String) = (front: "", back: "")

    override class func getDefaultSize() -> NSSize {
        return NSSize(width: 550, height: 300)
    }

    override func loadView() {
        let size = EditCardViewController.getDefaultSize()
        let view = EditCardView(frame: NSMakeRect(0, 0, size.width, size.height))
        view.delegate = self

        self.view = view
    }
}

extension EditCardViewController: EditCardViewDelegate {
    func didPressEnter() {
        // Regist card
        let realm = try! Realm()
        let card = Card()
        card.id = Card.lastId(realm)
        card.frontText = self.cardText.0
        card.backText = self.cardText.1
        let holder = CardHolder()
        
        // Regist card to default card holder
        // TODO: Select target card holder
        holder.id = 0
        let lastCards: List<Card> = CardHolder.lastCards(0, realm: realm)
        holder.cards.append(objectsIn: lastCards)
        holder.cards.append(card)
        
        try! realm.write {
            realm.add(card)
            realm.add(holder, update: true)
        }
        
        // Transition
        self.view.removeAllConstraints()
        self.delegate?.transitionTo(.search)
    }
    
    func updateCardText(front: String, back: String) {
        self.cardText = (front: front, back: back)
    }
}
