//
//  PlayCardWindow.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/25.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

class PlayCardWindowController: NSWindowController {
    override init(window: NSWindow?) {
        super.init(window: window)

        let vc = PlayCardViewController()
        self.window!.contentViewController = vc
        self.window?.hasShadow = true
        self.window?.titleVisibility = .hidden
        self.window?.titlebarAppearsTransparent = true
        self.window?.delegate = self
        self.window?.styleMask.insert(.fullSizeContentView)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.titleVisibility = .hidden
    }
}

// MARK: - WindowSizeCalculator
extension PlayCardWindowController: WindowSizeCalculator {
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

// MARK: - NSWindowDelegate
extension PlayCardWindowController: NSWindowDelegate {
    func windowDidMiniaturize(_: Notification) {
        print("Window minimized")
    }

    func windowWillClose(_: Notification) {
        print("Window closing")
    }

    func windowDidResignKey(_: Notification) {
        self.window?.orderOut(self)
    }
}

class KeyDetectableBorderlessWindow: NSWindow {
    override var canBecomeMain: Bool { return true }

    override var canBecomeKey: Bool { return true }
}
