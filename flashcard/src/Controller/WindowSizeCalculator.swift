//
//  WindowSizeCalculator.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/06/21.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import Cocoa

protocol WindowSizeCalculator {
    static func calcRect(screenSize: NSSize) -> NSRect
    static func defaultSize() -> NSSize
    static func defaultRect() -> NSRect
}
