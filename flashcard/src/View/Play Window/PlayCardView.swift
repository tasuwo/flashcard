//
//  PlayCardView.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/25.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa
import SpriteKit

let leftArrowKey = 123
let rightArrowKey = 124
let downArrowKey = 125
let upArrowKey = 126

protocol PlayCardViewDelegate {
    func didPressShuffleButton()
    func flip()
    func corrected()
    func failed()
}

// MARK: -
class PlayCardView: SKView {
    open var delegateToController: PlayCardViewDelegate?
    var menuView: NSView!
    var cardText: NSTextField!

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        menuView = NSView()
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuView.wantsLayer = true
        self.addSubview(menuView)

        let shuffleButton = myNSButton(title: "shuffle", target: self, action: #selector(PlayCardView.didPressShuffleButton))
        shuffleButton.sendAction(on: .keyDown)
        shuffleButton.translatesAutoresizingMaskIntoConstraints = false
        menuView.addSubview(shuffleButton)

        menuView.addConstraints([
            NSLayoutConstraint(item: shuffleButton, attribute: .centerY, relatedBy: .equal, toItem: menuView, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: shuffleButton, attribute: .right, relatedBy: .equal, toItem: menuView, attribute: .right, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: shuffleButton, attribute: .height, relatedBy: .equal, toItem: menuView, attribute: .height, multiplier: 1, constant: -6),
            NSLayoutConstraint(item: shuffleButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 70),
        ])

        self.addConstraints([
            NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frameRect.width),
            NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frameRect.height),

            NSLayoutConstraint(item: menuView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: menuView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: menuView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: menuView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30),
        ])
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PlayCardView {
    func didPressShuffleButton() {
        self.delegateToController?.didPressShuffleButton()
    }
}

extension PlayCardView {
    override var acceptsFirstResponder: Bool { return true }

    override func keyDown(with event: NSEvent) {
        let character = Int(event.keyCode)
        switch character {
        case leftArrowKey, rightArrowKey, upArrowKey, downArrowKey:
            break
        default:
            super.keyDown(with: event)
        }
    }

    override func keyUp(with event: NSEvent) {
        let character = Int(event.keyCode)
        switch character {
        case leftArrowKey:
            self.delegateToController?.flip()
        case rightArrowKey:
            self.delegateToController?.flip()
        case upArrowKey:
            self.delegateToController?.corrected()
        case downArrowKey:
            self.delegateToController?.failed()
        default:
            super.keyUp(with: event)
        }
    }
}
