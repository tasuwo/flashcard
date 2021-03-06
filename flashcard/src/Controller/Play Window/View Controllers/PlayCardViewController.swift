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

class PlayCardViewController: NSViewController {
    fileprivate var cards: [Card] = []
    fileprivate var index = 0 {
        didSet {
            if self.cards.count - 1 < self.index {
                scene?.showFinishEffect()
                self.index -= 1
                return
            }

            if self.index < 0 {
                self.index = 0
            }

            scene?.renderCardText(frontText: self.cards[self.index].frontText, backText: self.cards[self.index].backText)
        }
    }

    fileprivate var face: CardFace = .front
    fileprivate var viewInitiated: Bool = false
    fileprivate var scene: PlayCardScene?

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

        if !viewInitiated {
            let size = PlayCardViewController.size()
            let scene = PlayCardScene(size: CGSize(width: size.width, height: size.height))
            scene.backgroundColor = NSColor(cgColor: CGColor(red: 220 / 255, green: 220 / 255, blue: 220 / 255, alpha: 1))!
            self.scene = scene

            let skView = PlayCardView(frame: NSMakeRect(0, 0, size.width, size.height))
            skView.delegateToController = self

            self.view = skView
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

extension PlayCardViewController: ViewSizeProvider {}

extension PlayCardViewController: PlayCardViewDelegate {
    func flip() {
        switch self.face {
        case .front:
            self.scene?.flipCard()
            self.face = .back
            break
        case .back:
            self.scene?.flipCard()
            self.face = .front
            break
        }
    }

    func corrected() {
        let c = self.cards[self.index]
        let now = NSDate()
        let s = Score(isCorrect: true, date: now)
        Score.add(s, to: c)

        self.scene?.runEffect(isCorrected: true, callback: {
            self.index += 1
        })
    }

    func failed() {
        let c = self.cards[self.index]
        let now = NSDate()
        let s = Score(isCorrect: false, date: now)
        Score.add(s, to: c)

        self.scene?.runEffect(isCorrected: false, callback: {
            self.index += 1
        })
    }

    func didPressShuffleButton() {
        self.shuffleCards()
    }
}
