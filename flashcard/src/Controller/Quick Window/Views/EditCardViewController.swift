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
            view?.targetWord = self.targetDefinition!.title
        }
    }
    var cardText: (String, String) = (front: "", back: "")

    override class func getDefaultSize() -> NSSize {
        return NSSize(width: 800, height: 450)
    }

    override func loadView() {
        let size = EditCardViewController.getDefaultSize()
        let view = EditCardView(frame: NSMakeRect(0, 0, size.width, size.height))
        view.delegate = self

        self.view = view
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        let view = self.view as! EditCardView
        view.setResponder()
    }
}

extension EditCardViewController: EditCardViewDelegate {
    func updateCardText(front: String, back: String) {
        self.cardText = (front: front, back: back)
    }
    
    func cancel() {
        self.view.removeAllConstraints()
        self.delegate?.transitionTo(.search)
    }
    
    func didPressCommandEnter() {
        let card = Card(id: Card.lastId()+1, frontText: self.cardText.0, backText: self.cardText.1)
        if let s = AppSettings.get(), let hi = s.defaultHolderId, let h = CardHolder.get(hi) {
            Card.add(card, to: h)
        } else if let h = CardHolder.get(0) {
            // Save card to default holder
            Card.add(card, to: h)
        } else {
            // TODO: Show error message to user
        }

        // Transition
        self.view.removeAllConstraints()
        self.delegate?.transitionTo(.search)
    }
}
