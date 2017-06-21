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

extension WindowSizeCalculator where Self: PlayCardWindowController {
    static func calcRect(screenSize: NSSize) -> NSRect {
        return NSMakeRect(
            screenSize.width / 2 - defaultSize().width / 2,
            screenSize.height / 2 - defaultSize().height / 2,
            defaultSize().width,
            defaultSize().height
        )
    }

    static func defaultSize() -> NSSize {
        return NSSize(width: 400, height: 300)
    }

    static func defaultRect() -> NSRect {
        return NSRect(x: 0, y: 0, width: defaultSize().width, height: defaultSize().height)
    }
}

extension WindowSizeCalculator where Self: QuickWindowController {
    static func calcRect(screenSize: NSSize) -> NSRect {
        return NSMakeRect(
            screenSize.width / 2 - defaultSize().width / 2,
            screenSize.height * 2 / 3,
            defaultSize().width,
            defaultSize().height
        )
    }

    static func defaultSize() -> NSSize {
        return NSSize(width: 800, height: 60)
    }

    static func defaultRect() -> NSRect {
        return NSRect(x: 0, y: 0, width: defaultSize().width, height: defaultSize().height)
    }
}

extension WindowSizeCalculator where Self: SettingsWindowController {
    static func calcRect(screenSize: NSSize) -> NSRect {
        return NSMakeRect(
            screenSize.width / 2 - defaultSize().width / 2,
            screenSize.height / 2 - defaultSize().height / 2,
            defaultSize().width,
            defaultSize().height
        )
    }

    static func defaultSize() -> NSSize {
        return NSSize(width: 800, height: 600)
    }

    static func defaultRect() -> NSRect {
        return NSRect(x: 0, y: 0, width: defaultSize().width, height: defaultSize().height)
    }
}
