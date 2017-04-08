//
//  PlayCardScene.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/04/08.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import SpriteKit

class PlayCardScene: SKScene {
    var card: CardNode? = nil
    var correctedSign: SKLabelNode?
    var failedSign: SKLabelNode?
    
    func renderCardText(frontText: String, backText: String) {
        self.removeAllChildren()
        
        self.card = CardNode(texture: nil, color: .white, size: self.size)
        self.card?.setTexts(front: frontText, back: backText)
        self.card?.position = CGPoint(x: self.size.width/2, y: 10)
        self.card?.size = CGSize(width: self.size.width - 20, height: self.size.height - 40)
        self.addChild(card!)
        
        self.correctedSign = SKLabelNode(text: "☺️")
        self.correctedSign?.fontSize = 70
        self.correctedSign?.position = CGPoint(x: self.size.width/2, y: self.size.height/2 - 40)
        self.correctedSign?.isHidden = true
        self.addChild(self.correctedSign!)
        
        self.failedSign = SKLabelNode(text: "😭")
        self.failedSign?.fontSize = 70
        self.failedSign?.position = CGPoint(x: self.size.width/2, y: self.size.height/2 - 40)
        self.failedSign?.isHidden = true
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
