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
    fileprivate var cards = [(Int, String, String)]()
    fileprivate var index = 0
    fileprivate(set) var backCardText: String = ""
    fileprivate(set) var frontCardText: String = ""
    
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
        
        // Load cards
        // TODO: Select holder
        let realm = try! Realm()
        let cards = realm.objects(Card.self)
        for card in cards {
            self.cards.append((card.id, card.frontText, card.backText))
        }
        
        // Shuffle cards
        self.cards = self.cards.shuffle()
        self.index = 0
        self.backCardText = ""
        
        if self.cards.count > 0 {
            self.frontCardText = self.cards[index].1
        } else {
            self.frontCardText = ""
        }
        view.renderCardText(front: self.frontCardText, back: "")
    }
}

extension PlayCardViewController : PlayCardViewDelegate {
    func flipToNext() {
        let view = self.view as! PlayCardView
        self.index += 1
        
        if self.cards.count == 0 { return }
        
        if index >= self.cards.count {
            self.index = self.cards.count
            self.backCardText = self.cards[index-1].2
            self.frontCardText = ""
            
            view.renderCardText(front: self.frontCardText, back: self.backCardText)
            return
        }
        self.backCardText = self.cards[index-1].2
        self.frontCardText = self.cards[index].1
        
        view.renderCardText(front: self.frontCardText, back: self.backCardText)
    }
    
    func flipToPrevious() {
        let view = self.view as! PlayCardView
        self.index -= 1
        
        if self.cards.count == 0 { return }
        
        if self.index <= 0 {
            self.index = 0
            self.backCardText = ""
            self.frontCardText = self.cards[index].1
            
            view.renderCardText(front: self.frontCardText, back: self.backCardText)
            return
        }
        self.backCardText = self.cards[index-1].2
        self.frontCardText = self.cards[index].1
        
        view.renderCardText(front: self.frontCardText, back: self.backCardText)
    }
}
