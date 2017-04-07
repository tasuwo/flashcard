//
//  PlayCardView.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/25.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

let leftArrowKey = 123
let rightArrowKey = 124
let downArrowKey = 125
let upArrowKey = 126

protocol PlayCardViewDelegate {
    func didPressShuffleButton()
    func flipToLeft()
    func flipToRight()
    func flipToUp()
    func flipToDown()
}

// MARK: -
class PlayCardView : NSView {
    open var delegate : PlayCardViewDelegate?
    var menuView: NSView!
    var backText: NSTextField!
    var frontText: NSTextField!
    
    override init(frame: NSRect) {
        super.init(frame: frame)
        
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
        
        let textView = NSView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.wantsLayer = true
        self.addSubview(textView)
        
        self.addConstraints([
            NSLayoutConstraint(item: self, attribute: .width,  relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frame.width),
            NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frame.height),
            
            NSLayoutConstraint(item: menuView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: menuView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: menuView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: menuView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30),

            NSLayoutConstraint(item: textView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 30),
            NSLayoutConstraint(item: textView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: textView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: textView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: -30),
        ])
        
        backText = NSTextField()
        backText.isEditable = false
        backText.translatesAutoresizingMaskIntoConstraints = false
        textView.addSubview(backText)
        
        frontText = NSTextField()
        frontText.isEditable = false
        frontText.translatesAutoresizingMaskIntoConstraints = false
        textView.addSubview(frontText)
        
        textView.addConstraints([
            NSLayoutConstraint(item: backText, attribute: .centerX, relatedBy: .equal, toItem: textView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backText, attribute: .top, relatedBy: .equal, toItem: textView, attribute: .top, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: backText, attribute: .width, relatedBy: .equal, toItem: textView, attribute: .width, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: backText, attribute: .height, relatedBy: .equal, toItem: textView,  attribute: .height, multiplier: 0.5, constant: -15),

            NSLayoutConstraint(item: frontText, attribute: .centerX, relatedBy: .equal, toItem: textView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: frontText, attribute: .bottom, relatedBy: .equal, toItem: textView, attribute: .bottom, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: frontText, attribute: .width, relatedBy: .equal, toItem: textView, attribute: .width, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: frontText, attribute: .height, relatedBy: .equal, toItem: textView,  attribute: .height, multiplier: 0.5, constant: -15),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func renderCardText(front: String, back: String) {
        self.frontText.stringValue = front
        self.backText.stringValue = back
    }
    
    override func viewWillDraw() {
        menuView.layer?.backgroundColor = CGColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
    }
}

extension PlayCardView {
    func didPressShuffleButton() {
        self.delegate?.didPressShuffleButton()
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
            self.delegate?.flipToLeft()
        case upArrowKey:
            self.delegate?.flipToUp()
            break
        case rightArrowKey:
            self.delegate?.flipToRight()
        case downArrowKey:
            self.delegate?.flipToDown()
            break
        default:
            super.keyUp(with: event)
        }
    }
}
