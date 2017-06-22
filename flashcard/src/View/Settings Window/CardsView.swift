//
//  CardsView.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/22.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa
import RealmSwift

protocol CardsViewDelegate {
    func didPressAddCard()
    func didPressRemoveCard(selectedRow: Int)
}

class CardsView: NSView {
    fileprivate(set) var cardsList: CardTableView!
    fileprivate var footer: NSView!
    fileprivate var addCardButton: myNSButton!
    fileprivate var removeCardButton: myNSButton!
    fileprivate var container: NSScrollView!
    open var delegate: CardsViewDelegate?

    override init(frame: NSRect) {
        super.init(frame: frame)

        // Footer
        footer = NSView()
        footer.translatesAutoresizingMaskIntoConstraints = false

        addCardButton = myNSButton(title: "+", target: self, action: #selector(CardsView.didPressAddCard))
        addCardButton.translatesAutoresizingMaskIntoConstraints = false
        addCardButton.sendAction(on: .keyDown)
        footer.addSubview(addCardButton)

        removeCardButton = myNSButton(title: "-", target: self, action: #selector(CardsView.didPressRemoveCard))
        removeCardButton.translatesAutoresizingMaskIntoConstraints = false
        removeCardButton.sendAction(on: .keyDown)
        footer.addSubview(removeCardButton)

        footer.addConstraints([
            NSLayoutConstraint(item: addCardButton, attribute: .bottom, relatedBy: .equal, toItem: footer, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: addCardButton, attribute: .left, relatedBy: .equal, toItem: footer, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: addCardButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25),
            NSLayoutConstraint(item: addCardButton, attribute: .height, relatedBy: .equal, toItem: footer, attribute: .height, multiplier: 1, constant: 0),

            NSLayoutConstraint(item: removeCardButton, attribute: .bottom, relatedBy: .equal, toItem: footer, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: removeCardButton, attribute: .left, relatedBy: .equal, toItem: footer, attribute: .left, multiplier: 1, constant: 25),
            NSLayoutConstraint(item: removeCardButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25),
            NSLayoutConstraint(item: removeCardButton, attribute: .height, relatedBy: .equal, toItem: footer, attribute: .height, multiplier: 1, constant: 0),
        ])

        // Container
        cardsList = CardTableView()
        cardsList.translatesAutoresizingMaskIntoConstraints = true
        cardsList.setupSettings()

        container = NSScrollView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.documentView = cardsList

        self.addSubview(container)
        self.addSubview(footer)

        self.addConstraints([
            NSLayoutConstraint(item: container, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: container, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: container, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: container, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: -25),

            NSLayoutConstraint(item: footer, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: footer, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: footer, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: footer, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25),
        ])
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillDraw() {
        // editCardSpace.layer?.backgroundColor = CGColor(red: 236, green: 236, blue: 236, alpha: 0)
        footer.layer?.backgroundColor = CGColor(red: 203, green: 203, blue: 203, alpha: 0)
    }
}

extension CardsView {
    func didPressAddCard() {
        self.delegate?.didPressAddCard()
    }

    func didPressRemoveCard() {
        self.delegate?.didPressRemoveCard(selectedRow: self.cardsList.selectedRow)
    }
}
