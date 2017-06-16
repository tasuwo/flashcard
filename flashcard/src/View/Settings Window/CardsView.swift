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
    func didPressAddCardHolder()
    func didPressRemoveCardHolder(selectedRow: Int)
    func didPressAddCard()
    func didPressRemoveCard(selectedRow: Int)
}

class CardsView: NSView {
    fileprivate var sideBar: NSScrollView!
    fileprivate(set) var holdersList: CardHolderTableView!
    fileprivate var sideBarFooter: NSView!
    fileprivate var addHolderButton: myNSButton!
    fileprivate var removeHolderButton: myNSButton!
    fileprivate var editCardSpace: NSView!
    fileprivate var cardListContainer: NSScrollView!
    fileprivate(set) var cardsList: CardTableView!
    fileprivate var cardsListFooter: NSView!
    fileprivate var addCardButton: myNSButton!
    fileprivate var removeCardButton: myNSButton!
    open var delegate: CardsViewDelegate?

    override init(frame: NSRect) {
        super.init(frame: frame)

        holdersList = CardHolderTableView()
        holdersList.translatesAutoresizingMaskIntoConstraints = true
        holdersList.setupSettings()

        sideBarFooter = NSView()
        sideBarFooter.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sideBarFooter)

        addHolderButton = myNSButton(title: "+", target: self, action: #selector(CardsView.didPressAddCardHolder))
        addHolderButton.translatesAutoresizingMaskIntoConstraints = false
        addHolderButton.sendAction(on: .keyDown)
        sideBarFooter.addSubview(addHolderButton)

        removeHolderButton = myNSButton(title: "-", target: self, action: #selector(CardsView.didPressRemoveCardHolder))
        removeHolderButton.translatesAutoresizingMaskIntoConstraints = false
        removeHolderButton.sendAction(on: .keyDown)
        sideBarFooter.addSubview(removeHolderButton)

        sideBarFooter.addConstraints([
            NSLayoutConstraint(item: addHolderButton, attribute: .bottom, relatedBy: .equal, toItem: sideBarFooter, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: addHolderButton, attribute: .left, relatedBy: .equal, toItem: sideBarFooter, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: addHolderButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25),
            NSLayoutConstraint(item: addHolderButton, attribute: .height, relatedBy: .equal, toItem: sideBarFooter, attribute: .height, multiplier: 1, constant: 0),

            NSLayoutConstraint(item: removeHolderButton, attribute: .bottom, relatedBy: .equal, toItem: sideBarFooter, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: removeHolderButton, attribute: .left, relatedBy: .equal, toItem: sideBarFooter, attribute: .left, multiplier: 1, constant: 25),
            NSLayoutConstraint(item: removeHolderButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25),
            NSLayoutConstraint(item: removeHolderButton, attribute: .height, relatedBy: .equal, toItem: sideBarFooter, attribute: .height, multiplier: 1, constant: 0),
        ])

        sideBar = NSScrollView()
        sideBar.translatesAutoresizingMaskIntoConstraints = false
        sideBar.documentView = holdersList
        self.addSubview(sideBar)

        editCardSpace = NSView()
        editCardSpace.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(editCardSpace)

        self.addConstraints([
            NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frame.width),
            NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frame.height),

            NSLayoutConstraint(item: sideBar, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: sideBar, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: sideBar, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250),
            NSLayoutConstraint(item: sideBar, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: -25),

            NSLayoutConstraint(item: sideBarFooter, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: sideBarFooter, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: sideBarFooter, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250),
            NSLayoutConstraint(item: sideBarFooter, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25),

            NSLayoutConstraint(item: editCardSpace, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: editCardSpace, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 250),
            NSLayoutConstraint(item: editCardSpace, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -250),
            NSLayoutConstraint(item: editCardSpace, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0),
        ])

        cardsList = CardTableView()
        cardsList.translatesAutoresizingMaskIntoConstraints = true
        cardsList.setupSettings()

        cardListContainer = NSScrollView()
        cardListContainer.translatesAutoresizingMaskIntoConstraints = false
        cardListContainer.documentView = cardsList
        editCardSpace.addSubview(cardListContainer)

        cardsListFooter = NSView()
        cardsListFooter.translatesAutoresizingMaskIntoConstraints = false
        editCardSpace.addSubview(cardsListFooter)

        editCardSpace.addConstraints([
            NSLayoutConstraint(item: cardListContainer, attribute: .top, relatedBy: .equal, toItem: editCardSpace, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: cardListContainer, attribute: .left, relatedBy: .equal, toItem: editCardSpace, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: cardListContainer, attribute: .width, relatedBy: .equal, toItem: editCardSpace, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: cardListContainer, attribute: .height, relatedBy: .equal, toItem: editCardSpace, attribute: .height, multiplier: 1, constant: -25),

            NSLayoutConstraint(item: cardsListFooter, attribute: .bottom, relatedBy: .equal, toItem: editCardSpace, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: cardsListFooter, attribute: .left, relatedBy: .equal, toItem: editCardSpace, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: cardsListFooter, attribute: .width, relatedBy: .equal, toItem: editCardSpace, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: cardsListFooter, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25),
        ])

        addCardButton = myNSButton(title: "+", target: self, action: #selector(CardsView.didPressAddCard))
        addCardButton.translatesAutoresizingMaskIntoConstraints = false
        addCardButton.sendAction(on: .keyDown)
        cardsListFooter.addSubview(addCardButton)

        removeCardButton = myNSButton(title: "-", target: self, action: #selector(CardsView.didPressRemoveCard))
        removeCardButton.translatesAutoresizingMaskIntoConstraints = false
        removeCardButton.sendAction(on: .keyDown)
        cardsListFooter.addSubview(removeCardButton)

        cardsListFooter.addConstraints([
            NSLayoutConstraint(item: addCardButton, attribute: .bottom, relatedBy: .equal, toItem: cardsListFooter, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: addCardButton, attribute: .left, relatedBy: .equal, toItem: cardsListFooter, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: addCardButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25),
            NSLayoutConstraint(item: addCardButton, attribute: .height, relatedBy: .equal, toItem: cardsListFooter, attribute: .height, multiplier: 1, constant: 0),

            NSLayoutConstraint(item: removeCardButton, attribute: .bottom, relatedBy: .equal, toItem: cardsListFooter, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: removeCardButton, attribute: .left, relatedBy: .equal, toItem: cardsListFooter, attribute: .left, multiplier: 1, constant: 25),
            NSLayoutConstraint(item: removeCardButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25),
            NSLayoutConstraint(item: removeCardButton, attribute: .height, relatedBy: .equal, toItem: cardsListFooter, attribute: .height, multiplier: 1, constant: 0),
        ])
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillDraw() {
        editCardSpace.layer?.backgroundColor = CGColor(red: 236, green: 236, blue: 236, alpha: 0)
        cardsListFooter.layer?.backgroundColor = CGColor(red: 203, green: 203, blue: 203, alpha: 0)
    }
}

extension CardsView {
    func didPressAddCard() {
        self.delegate?.didPressAddCard()
    }

    func didPressRemoveCard() {
        self.delegate?.didPressRemoveCard(selectedRow: self.cardsList.selectedRow)
    }

    func didPressAddCardHolder() {
        self.delegate?.didPressAddCardHolder()
    }

    func didPressRemoveCardHolder() {
        self.delegate?.didPressRemoveCardHolder(selectedRow: self.holdersList.selectedRow)
    }
}
