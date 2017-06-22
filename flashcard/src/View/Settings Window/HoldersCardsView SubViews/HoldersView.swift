//
//  HoldersView.swift
//  flashcard
//
//  Created by 兎澤　佑　 on 2017/06/22.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import Cocoa

protocol HoldersViewDelegate {
    func didPressAddCardHolder()
    func didPressRemoveCardHolder(selectedRow: Int)
}

class HoldersView: NSView {
    open var delegate: HoldersViewDelegate?
    fileprivate(set) var holdersList: CardHolderTableView!
    fileprivate var footer: NSView!
    fileprivate var addHolderButton: myNSButton!
    fileprivate var removeHolderButton: myNSButton!
    fileprivate var container: NSScrollView!

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        // Footer
        footer = NSView()
        footer.translatesAutoresizingMaskIntoConstraints = false

        addHolderButton = myNSButton(title: "+", target: self, action: #selector(HoldersView.didPressAddCardHolder))
        addHolderButton.translatesAutoresizingMaskIntoConstraints = false
        addHolderButton.sendAction(on: .keyDown)
        footer.addSubview(addHolderButton)

        removeHolderButton = myNSButton(title: "-", target: self, action: #selector(HoldersView.didPressRemoveCardHolder))
        removeHolderButton.translatesAutoresizingMaskIntoConstraints = false
        removeHolderButton.sendAction(on: .keyDown)
        footer.addSubview(removeHolderButton)

        footer.addConstraints([
            NSLayoutConstraint(item: addHolderButton, attribute: .bottom, relatedBy: .equal, toItem: footer, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: addHolderButton, attribute: .left, relatedBy: .equal, toItem: footer, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: addHolderButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25),
            NSLayoutConstraint(item: addHolderButton, attribute: .height, relatedBy: .equal, toItem: footer, attribute: .height, multiplier: 1, constant: 0),

            NSLayoutConstraint(item: removeHolderButton, attribute: .bottom, relatedBy: .equal, toItem: footer, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: removeHolderButton, attribute: .left, relatedBy: .equal, toItem: footer, attribute: .left, multiplier: 1, constant: 25),
            NSLayoutConstraint(item: removeHolderButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25),
            NSLayoutConstraint(item: removeHolderButton, attribute: .height, relatedBy: .equal, toItem: footer, attribute: .height, multiplier: 1, constant: 0),
        ])

        // Container
        holdersList = CardHolderTableView()
        holdersList.translatesAutoresizingMaskIntoConstraints = true
        holdersList.setupSettings()

        container = NSScrollView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.documentView = holdersList

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
}

extension HoldersView: HoldersViewDelegate {
    func didPressRemoveCardHolder(selectedRow _: Int) {
        self.delegate?.didPressRemoveCardHolder(selectedRow: self.holdersList.selectedRow)
    }

    func didPressAddCardHolder() {
        self.delegate?.didPressAddCardHolder()
    }
}
