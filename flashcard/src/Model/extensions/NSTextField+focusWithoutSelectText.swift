//
//  NSTextField+focusWithoutSelectText.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/04/02.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import Cocoa

extension NSTextField {
    func focusWithoutSelectText(_: Any?) {
        self.selectText(self)
        self.currentEditor()?.selectedRange = NSMakeRange(self.stringValue.characters.count, 0)
    }
}
