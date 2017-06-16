//
//  CardNode.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/04/08.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import SpriteKit

class CardNode: SKSpriteNode {
    var frontText: String
    var backText: String
    var textLabel: SKLabelNode
    var faceUp: Bool = true

    override init(texture: SKTexture?, color: NSColor, size: CGSize) {
        self.frontText = ""
        self.backText = ""
        self.textLabel = SKLabelNode()
        super.init(texture: texture, color: color, size: size)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.0)
    }

    func setTexts(front: String, back: String) {
        self.frontText = front
        self.backText = back
        self.textLabel = SKLabelNode(text: self.frontText)
        self.textLabel.fontName = NSFont.systemFont(ofSize: NSFont.systemFontSize()).fontName
        self.textLabel.fontColor = .black
        self.textLabel.position = CGPoint(x: 0, y: self.size.height / 2 - 20)
        self.removeAllChildren()
        self.addChild(self.textLabel)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func flip() {
        let firstHalfFlip = SKAction.scaleX(to: 0.0, duration: 0.07)
        let secondHalfFlip = SKAction.scaleX(to: 1.0, duration: 0.07)

        setScale(1.0)

        if faceUp {
            run(firstHalfFlip) {
                self.textLabel.text = self.backText
                self.run(secondHalfFlip)
            }
        } else {
            run(firstHalfFlip) {
                self.textLabel.text = self.frontText
                self.run(secondHalfFlip)
            }
        }
        faceUp = !faceUp
    }
}
