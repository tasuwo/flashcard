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
    func transitionTo(_ view: QuickWindowViewType)
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

// MARK: - NSWindowDelegate
extension QuickWindowController: NSWindowDelegate {
    func windowDidResignKey(_: Notification) {
        self.window?.orderOut(self)
    }
}

// MARK: - DElegateToSearchWindow
extension QuickWindowController: DelegateToQuickWindow {
    func transitionTo(_ T: QuickWindowViewType) {
        if T.isType(of: self.contentViewController!.view) { return }

        let newVC = T.viewControllerType().init()
        newVC.delegate = self
        self.resize(T.viewControllerType().getDefaultSize(), animate: false)
        self.contentViewController = newVC
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
