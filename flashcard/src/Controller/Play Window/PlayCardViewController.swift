//
//  PlayCardViewController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/25.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa
import RealmSwift

enum CardFace {
    case back, front
}

class PlayCardViewController: QuickWindowViewController {
    fileprivate var cards: [Card] = []
    fileprivate var index = 0 {
        didSet {
            let view = self.view as? PlayCardView
            
            if self.cards.count - 1 < self.index {
                self.index -= 1
            }
            
            if self.index < 0 {
                self.index = 0
            }

            view?.renderCardText(text: self.cards[self.index].frontText)
        }
    }
    fileprivate var face: CardFace = .front
    
    override class func getDefaultSize() -> NSSize {
        return NSSize(width: 400, height: 300)
    }
    
    class func getResultViewHeight() -> CGFloat {
        return CGFloat(50)
    }
    
    override func loadView() {
        let size = PlayCardViewController.getDefaultSize()
        let view = PlayCardView(frame: NSMakeRect(0, 0, size.width, size.height))
        view.delegate = self
        self.view = view
        
        shuffleCards()
    }
    
    func shuffleCards() {
        // TODO: Select holder
        self.cards = Array(Card.all(in: 0).shuffle())
        self.index = 0
    }
}

extension PlayCardViewController : PlayCardViewDelegate {
    func flip() {
        let view = self.view as? PlayCardView
        let card = self.cards[self.index]
        switch self.face {
        case .front:
            view?.renderCardText(text: card.backText)
            self.face = .back
            break
        case .back:
            view?.renderCardText(text: card.frontText)
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
