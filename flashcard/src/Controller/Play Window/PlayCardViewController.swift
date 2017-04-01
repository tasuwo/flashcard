//
//  PlayCardViewController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/25.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa
import RealmSwift

class PlayCardViewController: QuickWindowViewController {
    fileprivate var cards: [Card] = []
    fileprivate var index = 0 {
        didSet {
            let view = self.view as? PlayCardView
            
            if self.cards.count == 0 {
                view?.renderCardText(front: "", back: "")
                return
            }
            
            if self.index <= 0 {
                self.index = 0
                view?.renderCardText(front: self.cards[self.index].frontText, back: "")
                return
            }
            
            if self.index >= self.cards.count {
                self.index = self.cards.count
                view?.renderCardText(front: "", back: self.cards[self.index - 1].backText)
                return
            }
            
            view?.renderCardText(front: self.cards[self.index].frontText, back: self.cards[self.index - 1].backText)
        }
    }
    
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
    
    override func viewDidAppear() {
        shuffleCards()
    }
    
    func shuffleCards() {
        // TODO: Select holder
        let cards = Card.all(in: 0)
        if let cds = cards?.shuffle() {
            self.cards = cds
            self.index = 0
        }
    }
}

extension PlayCardViewController : PlayCardViewDelegate {
    func flipToNext() {
        self.index += 1
    }
    
    func flipToPrevious() {
        self.index -= 1
    }
}
