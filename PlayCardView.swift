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

protocol PlayCardViewDelegate {
    func flipToNext()
    func flipToPrevious()
}

// MARK: -
class PlayCardView : NSView {
    open var delegate : PlayCardViewDelegate?
    var backText: NSTextField!
    var frontText: NSTextField!
    
    override init(frame: NSRect) {
        super.init(frame: frame)
        
        backText = NSTextField()
        backText.isEditable = false
        backText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(backText)
        
        frontText = NSTextField()
        frontText.isEditable = false
        frontText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(frontText)
        
        self.addConstraints([
            NSLayoutConstraint(item: self, attribute: .width,  relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frame.width),
            NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frame.height),
            
            NSLayoutConstraint(item: backText, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX,        multiplier: 1,   constant: 0),
            NSLayoutConstraint(item: backText, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY,        multiplier: 0.5, constant: 0),
            NSLayoutConstraint(item: backText, attribute: .width,   relatedBy: .equal, toItem: self, attribute: .width,          multiplier: 1,   constant: -30),
            NSLayoutConstraint(item: backText, attribute: .height,  relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1,   constant: 120),

            NSLayoutConstraint(item: frontText, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX,        multiplier: 1,   constant: 0),
            NSLayoutConstraint(item: frontText, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY,        multiplier: 0.5, constant: 150),
            NSLayoutConstraint(item: frontText, attribute: .width,   relatedBy: .equal, toItem: self, attribute: .width,          multiplier: 1,   constant: -30),
            NSLayoutConstraint(item: frontText, attribute: .height,  relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1,   constant: 120),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func renderCardText(front: String, back: String) {
        self.frontText.stringValue = front
        self.backText.stringValue = back
    }
}

extension PlayCardView {
    override var acceptsFirstResponder: Bool { get { return true } }

    override func keyDown(with event: NSEvent) {
        let character = Int(event.keyCode)
        switch character {
        case leftArrowKey, rightArrowKey:
            break
        default:
            super.keyDown(with: event)
        }
    }
    
    override func keyUp(with event: NSEvent) {
        let character = Int(event.keyCode)
        switch character {
        case leftArrowKey:
            self.delegate?.flipToPrevious()
            break
        case rightArrowKey:
            self.delegate?.flipToNext()
            break
        default:
            super.keyUp(with: event)
        }
    }
}
