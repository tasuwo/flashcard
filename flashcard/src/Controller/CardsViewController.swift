//
//  CardsViewController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/22.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

class CardsViewController: NSViewController {
    override func loadView() {
        let winSize = SettingsWindowController.winSize
        let view = CardsView(frame: NSMakeRect(0,0,winSize.width, winSize.height))
        view.delegate = self
        
        self.view = view
    }
}

extension CardsViewController: CardsViewDelegate {
    func cardholderSelectionDidChange(_ row: Int) {
        let view = self.view as! CardsView
        view.holdersList.loadHolders()
    }
    
    func cardTextDidChange(id: Int, prop: String, value: String) {}
}
