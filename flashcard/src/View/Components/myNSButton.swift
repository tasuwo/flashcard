//
//  myNSButton.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/04/01.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import Cocoa

class myNSButton: NSButton {
    override func viewWillDraw() {
        self.isBordered = true
        self.setButtonType(.accelerator)
    }
}
