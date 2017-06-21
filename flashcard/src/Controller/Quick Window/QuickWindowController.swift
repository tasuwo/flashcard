//
//  SearchWindowController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/03.
//  Copyright © 2017 tasuku tozawa. All rights reserved.
//

import Cocoa

protocol DelegateToQuickWindow {
    func lookup(_ word: String)
    func resize(_ size: NSSize, animate: Bool)
    func transitionTo(_ newViewController: NSViewController, size: NSSize)
    func cancel()
}

class QuickWindowController: NSWindowController {
    let dic = CoreServiceDictionary()

    override init(window: NSWindow?) {
        super.init(window: window)

        let searchVC = SearchViewController()
        searchVC.delegate = self
        self.window!.contentViewController = searchVC

        window!.delegate = self

        self.window!.hasShadow = true
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func windowDidLoad() {
        super.windowDidLoad()
    }
}

// MARK: - WindowSizeCalculator
extension QuickWindowController: WindowSizeCalculator {
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

// MARK: - NSWindowDelegate
extension QuickWindowController: NSWindowDelegate {
    func windowDidResignKey(_: Notification) {
        self.window?.orderOut(self)
    }
}

// MARK: - DElegateToSearchWindow
extension QuickWindowController: DelegateToQuickWindow {
    func transitionTo(_ newViewController: NSViewController, size: NSSize) {
        self.resize(size, animate: false)
        self.contentViewController = newViewController
    }

    func lookup(_ word: String) {
        // TODO: Dictionary search
        let results = dic.lookUp(word)

        if let v = self.contentViewController as? SearchViewController {
            if results.count > 0 {
                v.displayResult(results)
            } else {
                v.clearResults()
            }
        }
    }

    func resize(_ size: NSSize, animate: Bool) {
        // TODO: Coordiante window's origin position
        let origin = (
            x: self.window!.frame.origin.x + self.window!.frame.width / 2 - size.width / 2,
            y: self.window!.frame.origin.y + self.window!.frame.height - size.height
        )
        self.window?.setFrame(NSMakeRect(origin.x, origin.y, size.width, size.height), display: true, animate: animate)
    }

    func cancel() {
        self.window?.orderOut(self)
    }
}
