//
//  HoldersCardsViewController.swift
//  flashcard
//
//  Created by 兎澤　佑　 on 2017/06/22.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import Cocoa

class HoldersCardsViewController: NSViewController {
    fileprivate var holdersVC: HoldersViewController!
    fileprivate var cardsVC: CardsViewController!

    override func loadView() {
        let winSize = SettingsWindowController.defaultSize()
        let view = HoldersCardsView(frame: NSMakeRect(0, 0, winSize.width, winSize.height))

        holdersVC = HoldersViewController(view: view.holdersView, presenter: CardHolderPresenterImpl())
        cardsVC = CardsViewController(view: view.cardsView, presenter: CardPresenterImpl())
        holdersVC.delegate = cardsVC

        self.view = view
    }
}
