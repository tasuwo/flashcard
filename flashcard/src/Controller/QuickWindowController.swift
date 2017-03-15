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
}

class QuickWindowController : NSWindowController {
    let dic = CoreServiceDictionary()

    override init(window: NSWindow?) {
        super.init(window: window)

        let searchVC = SearchViewController()
        searchVC.delegate = self
        self.window!.contentViewController = searchVC
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.delegate = self
    }
}

// MARK: - NSWindowDelegate
extension QuickWindowController : NSWindowDelegate {
    func windowDidMiniaturize(_ notification: Notification) {
        print("Window minimized")
    }
    
    func windowWillClose(_ notification: Notification) {
        print("Window closing")
    }
}

// MARK: - DElegateToSearchWindow
extension QuickWindowController : DelegateToQuickWindow {
    func transitionTo(_ T: QuickWindowViewType) {
        if T.isType(of: self.contentViewController!.view) { return }

        let newVC = T.viewControllerType().init()
        newVC.delegate = self
        self.resize(T.viewControllerType().getDefaultSize(), animate: true)
        self.contentViewController = newVC
    }

    func lookup(_ word: String) {
        // TODO: Dictionary search
        let result = dic.lookUp(word)
        if let r = result {
            // Display results
            // TODO: Extruct title from result. Get result candidates and set.
            if let v = self.contentViewController as? SearchViewController {
                v.displayResult([ SearchResultInfo(title: "test", body: r) ])
            }
        } else {
            if let v = self.contentViewController as? SearchViewController {
                v.clearResults()
            }
        }
    }
    
    func resize(_ size: NSSize, animate: Bool) {
        // TODO: Coordiante window's origin position
        let origin = (
            x: self.window!.frame.origin.x + self.window!.frame.width/2 - size.width/2,
            y: self.window!.frame.origin.y + self.window!.frame.height - size.height
        )
        self.window?.setFrame(NSMakeRect(origin.x, origin.y, size.width, size.height), display: true, animate: animate)
    }
}
