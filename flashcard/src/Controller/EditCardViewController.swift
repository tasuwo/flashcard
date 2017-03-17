//
//  EditCardViewController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/10.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

class EditCardViewController: QuickWindowViewController {
    var targetDefinition: SearchResultInfo? = nil {
        didSet {
            let view = self.view as? EditCardView
            view?.definition = self.targetDefinition!.body
        }
    }
    var cardText: (String, String) = (front: "", back: "")

    override class func getDefaultSize() -> NSSize {
        return NSSize(width: 550, height: 300)
    }

    override func loadView() {
        let size = EditCardViewController.getDefaultSize()
        let view = EditCardView(frame: NSMakeRect(0, 0, size.width, size.height))
        view.delegate = self

        self.view = view
    }
}

extension EditCardViewController: EditCardViewDelegate {
    func didPressEnter() {
        Swift.print(self.cardText)
        self.delegate?.transitionTo(.search)
    }
    
    func updateCardText(front: String, back: String) {
        self.cardText = (front: front, back: back)
    }
}
