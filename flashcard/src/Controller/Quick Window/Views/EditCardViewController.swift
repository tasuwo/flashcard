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
}
