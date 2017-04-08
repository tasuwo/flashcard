//
//  PlayCardViewController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/25.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa
import RealmSwift
import SpriteKit

enum CardFace {
    case back, front
}

class PlayCardViewController: QuickWindowViewController {
    fileprivate var cards: [Card] = []
    fileprivate var index = 0 {
        didSet {
            let view = self.scene as? PlayCardView
            
            if self.cards.count - 1 < self.index {
                self.index -= 1
            }
            
            if self.index < 0 {
                self.index = 0
            }

            view?.renderCardText(frontText: self.cards[self.index].frontText, backText: self.cards[self.index].backText)
        }
    }
    fileprivate var face: CardFace = .front
    fileprivate var viewInitiated: Bool = false
    fileprivate var scene: SKScene? = nil
    
    override class func getDefaultSize() -> NSSize {
        return NSSize(width: 400, height: 300)
    }
    
    class func getResultViewHeight() -> CGFloat {
        return CGFloat(50)
    }
    
    override func loadView() {
        self.view = SKView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayout() {
        super.viewWillLayout()
        
        if (!viewInitiated) {
            let size = PlayCardViewController.getDefaultSize()
            let scene = PlayCardView(size: CGSize(width: size.width, height: size.height))
            scene.delegateToController = self
            self.scene = scene
            
            self.view = scene.baseView
            let skView = self.view as! SKView
            skView.presentScene(self.scene)
            
            shuffleCards()
            
            self.viewInitiated = true
        }
    }
    
    func shuffleCards() {
        // TODO: Select holder
        self.cards = Array(Card.all(in: 0).shuffle())
        self.index = 0
    }
}

extension PlayCardViewController : PlayCardViewDelegate {
    func flip() {
        let view = self.scene as? PlayCardView
        switch self.face {
        case .front:
            view?.flipCard()
            self.face = .back
            break
        case .back:
            view?.flipCard()
            self.face = .front
            break
        }
    }
    
    func corrected() {
        let c = self.cards[self.index]
        let now = NSDate()
        let s = Score(isCorrect: true, date: now)
        Score.add(s, to: c)

        self.index += 1
    }
    
    func failed() {
        let c = self.cards[self.index]
        let now = NSDate()
        let s = Score(isCorrect: false, date: now)
        Score.add(s, to: c)

        self.index += 1
    }
    
    func didPressShuffleButton() {
        self.shuffleCards()
    }
}
