//
//  EditCardViewController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/10.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

extension ViewSizeProvider where Self: EditCardViewController {
    static func size() -> NSSize {
        return NSSize(width: 800, height: 450)
    }
}

class EditCardViewController: NSViewController, ViewSizeProvider {
    open var delegate: DelegateToQuickWindow?

    var targetDefinition: SearchResultInfo? {
        didSet {
            let view = self.view as? EditCardView
            view?.definition = self.targetDefinition!.body
            view?.targetWord = self.targetDefinition!.title
        }
    }

    var cardText: (String, String) = (front: "", back: "")

    override func loadView() {
        let size = EditCardViewController.size()
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
        let vc = SearchViewController()
        vc.delegate = self.delegate
        self.delegate?.transitionTo(vc, size: SearchViewController.size())
    }

    func didPressCommandEnter() {
        let card = Card(id: Card.lastId() + 1, frontText: self.cardText.0, backText: self.cardText.1)
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
        let vc = SearchViewController()
        vc.delegate = self.delegate
        self.delegate?.transitionTo(vc, size: SearchViewController.size())
    }
}
