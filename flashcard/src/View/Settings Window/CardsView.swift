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
    func cardholderSelectionDidChange(_ row: Int)
}

class CardsView : NSView {
    var sideBar: NSScrollView!
    var holdersList: CardHolderTableView!
    var editCardSpace: NSView!
    var cardListContainer: NSScrollView!
    var cardsList: CardTableView!
    open var delegate: CardsViewDelegate? {
        didSet {
            self.cardsList.cardsViewDelegate = self.delegate
            self.holdersList.cardsViewDelegate = self.delegate
        }
    }

    override init(frame: NSRect) {
        super.init(frame: frame)
        
        holdersList = CardHolderTableView()
        holdersList.translatesAutoresizingMaskIntoConstraints = true
        holdersList.setupSettings()
        let holdersPresenter = CardHoldersListPresenter()
        holdersPresenter.load()
        holdersList.dataSource = holdersPresenter
        
        sideBar = NSScrollView()
        sideBar.translatesAutoresizingMaskIntoConstraints = false
        sideBar.documentView = holdersList
        self.addSubview(sideBar)
        
        editCardSpace = NSView()
        editCardSpace.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(editCardSpace)
        
        self.addConstraints([
            NSLayoutConstraint(item: self, attribute: .width,  relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frame.width),
            NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frame.height),
            
            NSLayoutConstraint(item: sideBar, attribute: .top,    relatedBy: .equal, toItem: self, attribute: .top,            multiplier: 1, constant: 0),
            NSLayoutConstraint(item: sideBar, attribute: .left,   relatedBy: .equal, toItem: self, attribute: .left,           multiplier: 1, constant: 0),
            NSLayoutConstraint(item: sideBar, attribute: .width,  relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 250),
            NSLayoutConstraint(item: sideBar, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height,         multiplier: 1, constant: 0),
            
            NSLayoutConstraint(item: editCardSpace, attribute: .top,    relatedBy: .equal, toItem: self, attribute: .top,    multiplier: 1, constant: 0),
            NSLayoutConstraint(item: editCardSpace, attribute: .left,   relatedBy: .equal, toItem: self, attribute: .left,   multiplier: 1, constant: 250),
            NSLayoutConstraint(item: editCardSpace, attribute: .width,  relatedBy: .equal, toItem: self, attribute: .width,  multiplier: 1, constant: -250),
            NSLayoutConstraint(item: editCardSpace, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0)
        ])
        
        cardsList = CardTableView()
        cardsList.translatesAutoresizingMaskIntoConstraints = true
        cardsList.setupSettings()
        let cardsPresenter = CardsListPresenter()
        cardsList.presenter = cardsPresenter
        
        cardListContainer = NSScrollView()
        cardListContainer.translatesAutoresizingMaskIntoConstraints = false
        cardListContainer.documentView = cardsList
        editCardSpace.addSubview(cardListContainer)
        
        editCardSpace.addConstraints([
            NSLayoutConstraint(item: cardListContainer, attribute: .top,     relatedBy: .equal, toItem: editCardSpace, attribute: .top,    multiplier: 1, constant: 0),
            NSLayoutConstraint(item: cardListContainer, attribute: .left,    relatedBy: .equal, toItem: editCardSpace, attribute: .left,   multiplier: 1, constant: 0),
            NSLayoutConstraint(item: cardListContainer, attribute: .width,   relatedBy: .equal, toItem: editCardSpace, attribute: .width,  multiplier: 1, constant: 0),
            NSLayoutConstraint(item: cardListContainer, attribute: .height,  relatedBy: .equal, toItem: editCardSpace, attribute: .height, multiplier: 1, constant: 0),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDraw() {
        editCardSpace.layer?.backgroundColor = CGColor(red: 236, green: 236, blue: 236, alpha: 0)
    }
}
