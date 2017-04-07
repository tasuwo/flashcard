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
class PlayCardView : SKScene {
    open var delegateToController : PlayCardViewDelegate?
    var baseView: SKView!
    var menuView: NSView!
    var cardText: NSTextField!
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.baseView = SKView(frame: NSMakeRect(0, 0, size.width, size.height))
        self.baseView.wantsLayer = true
        
        menuView = NSView()
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuView.wantsLayer = true
        self.baseView.addSubview(menuView)

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
        
        let textView = NSView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.wantsLayer = true
        self.baseView.addSubview(textView)
        
        self.baseView.addConstraints([
            NSLayoutConstraint(item: self.baseView, attribute: .width,  relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frame.width),
            NSLayoutConstraint(item: self.baseView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frame.height),
            
            NSLayoutConstraint(item: menuView, attribute: .top, relatedBy: .equal, toItem: self.baseView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: menuView, attribute: .left, relatedBy: .equal, toItem: self.baseView, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: menuView, attribute: .width, relatedBy: .equal, toItem: self.baseView, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: menuView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30),

            NSLayoutConstraint(item: textView, attribute: .top, relatedBy: .equal, toItem: self.baseView, attribute: .top, multiplier: 1, constant: 30),
            NSLayoutConstraint(item: textView, attribute: .left, relatedBy: .equal, toItem: self.baseView, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: textView, attribute: .width, relatedBy: .equal, toItem: self.baseView, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: textView, attribute: .height, relatedBy: .equal, toItem: self.baseView, attribute: .height, multiplier: 1, constant: -30),
        ])
        
        cardText = NSTextField()
        cardText.isEditable = false
        cardText.translatesAutoresizingMaskIntoConstraints = false
        textView.addSubview(cardText)
        
        textView.addConstraints([
            NSLayoutConstraint(item: cardText, attribute: .centerX, relatedBy: .equal, toItem: textView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: cardText, attribute: .top, relatedBy: .equal, toItem: textView, attribute: .top, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: cardText, attribute: .width, relatedBy: .equal, toItem: textView, attribute: .width, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: cardText, attribute: .height, relatedBy: .equal, toItem: textView,  attribute: .height, multiplier: 1, constant: -20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func renderCardText(text: String) {
        self.cardText.stringValue = text
    }
}

extension PlayCardView {
    func didPressShuffleButton() {
        self.delegateToController?.didPressShuffleButton()
    }
}

extension PlayCardView {
    override var acceptsFirstResponder: Bool { get { return true } }

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
