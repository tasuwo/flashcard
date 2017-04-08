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
    var textView: NSView!
    var cardText: NSTextField!
    var card: CardNode? = nil
    var correctedSign: SKSpriteNode?
    var failedSign: SKSpriteNode?
    
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
        
        self.textView = NSView()
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.textView.wantsLayer = true
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func renderCardText(frontText: String, backText: String) {
        self.card = CardNode(texture: nil, color: .white, size: self.baseView.frame.size)
        self.card?.setTexts(front: frontText, back: backText)
        self.card?.position = CGPoint(x: self.baseView.frame.width/2, y: 10)
        self.card?.size = CGSize(width: self.baseView.frame.width - 20, height: self.baseView.frame.height - 40)

        self.removeAllChildren()
        self.addChild(card!)
        
        self.correctedSign = SKSpriteNode(texture: nil, color: .red, size: CGSize(width: 100, height: 100))
        self.correctedSign?.position = CGPoint(x: self.baseView.frame.width/2, y: self.baseView.frame.height/2)
        self.correctedSign?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.failedSign = SKSpriteNode(texture: nil, color: .blue, size: CGSize(width: 100, height: 100))
        self.failedSign?.position = CGPoint(x: self.baseView.frame.width/2, y: self.baseView.frame.height/2)
        self.failedSign?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.correctedSign?.isHidden = true
        self.failedSign?.isHidden = true
        self.addChild(self.correctedSign!)
        self.addChild(self.failedSign!)
    }
    
    func runEffect(isCorrected: Bool, callback: @escaping () -> Void) {
        let xWiggleIn = SKAction.scaleX(to: 1.0, duration: 0.05)
        let xWiggleOut = SKAction.scaleX(to: 1.2, duration: 0.05)
        let yWiggleIn = SKAction.scaleY(to: 1.0, duration: 0.05)
        let yWiggleOut = SKAction.scaleY(to: 1.2, duration: 0.05)
        let wiggleIn = SKAction.sequence([xWiggleIn, yWiggleIn])
        let wiggleOut = SKAction.sequence([xWiggleOut, yWiggleOut])
        let wiggle = SKAction.sequence([wiggleOut, wiggleIn, SKAction.wait(forDuration: 0.5)])
        
        if isCorrected {
            self.correctedSign?.isHidden = false
            self.correctedSign?.run(SKAction.repeat(wiggle, count: 1), completion: callback)
        } else {
            self.failedSign?.isHidden = false
            self.failedSign?.run(SKAction.repeat(wiggle, count: 1), completion: callback)
        }
    }
    
    func flipCard() {
        self.card?.flip()
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
