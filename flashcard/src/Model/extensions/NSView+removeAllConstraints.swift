//
//  NSView+removeAllConstraints.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/17.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

extension NSView {
    func removeAllConstraints() {
        self.removeConstraints(self.constraints)
    }
}
