//
//  EditCardViewController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/10.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

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
        let card = Card()
        card.id = Card.lastId() + 1
        card.frontText = self.cardText.0
        card.backText = self.cardText.1
        // Regist card to default card holder
        // TODO: Select target card holder
        if let holder = CardHolder.get(0) {
            Card.add(card, to: holder)
        } else {
            
        }
        
        // Transition
        self.view.removeAllConstraints()
        self.delegate?.transitionTo(.search)
    }
    
    func updateCardText(front: String, back: String) {
        self.cardText = (front: front, back: back)
    }
}
