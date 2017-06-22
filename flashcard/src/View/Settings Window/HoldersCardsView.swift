//
//  HoldersCardsView.swift
//  flashcard
//
//  Created by 兎澤　佑　 on 2017/06/22.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import Cocoa

class HoldersCardsView: NSView {
    fileprivate(set) var cardsView: CardsView!
    fileprivate(set) var holdersView: HoldersView!

    override init(frame: NSRect) {
        super.init(frame: frame)

        holdersView = HoldersView()
        holdersView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(holdersView)

        cardsView = CardsView()
        cardsView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cardsView)

        self.addConstraints([
            NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frame.width),
            NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frame.height),

            NSLayoutConstraint(item: holdersView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: holdersView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: holdersView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250),
            NSLayoutConstraint(item: holdersView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0),

            NSLayoutConstraint(item: cardsView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: cardsView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 250),
            NSLayoutConstraint(item: cardsView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -250),
            NSLayoutConstraint(item: cardsView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0),
        ])
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
