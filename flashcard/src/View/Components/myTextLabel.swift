//
//  NSTextLabel.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/04/01.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import Cocoa

class myTextLabel : NSTextField {
    convenience init(with text: String) {
        self.init()
        self.stringValue = text
        self.isBezeled = false
        self.drawsBackground = false
        self.isEditable = false
        self.isSelectable = false
        self.alignment = .right
    }
}
