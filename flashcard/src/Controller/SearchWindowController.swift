//
//  SearchWindowController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/03.
//  Copyright © 2017 tasuku tozawa. All rights reserved.
//

import Cocoa

enum SearchWindowViewType {
    case search
    case editCard
    
    func isType(of view: NSView) -> Bool {
        switch self {
        case .search:
            return (view is SearchView)
        case .editCard:
            return (view is EditCardView)
        }
    }
    
    func viewControllerType() -> NSViewController.Type {
        switch self {
        case .search:
            return SearchViewController.self
        case .editCard:
            return EditCardViewController.self
        }
    }
}

protocol DelegateToSearchWindow {
    func lookup(_ word: String)
    func resize(_ size: NSSize, animate: Bool)
    func transitionTo(_ view: SearchWindowViewType)
}

class SearchWindowController : NSWindowController {
    static let winSize = NSSize(width: 800, height: 50)

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
extension SearchWindowController : NSWindowDelegate {
    func windowDidMiniaturize(_ notification: Notification) {
        print("Window minimized")
    }
    
    func windowWillClose(_ notification: Notification) {
        print("Window closing")
    }
}

// MARK: - DElegateToSearchWindow
extension SearchWindowController : DelegateToSearchWindow {
    func transitionTo(_ T: SearchWindowViewType) {
        if T.isType(of: self.contentViewController!.view) { return }
        
        // TODO: Set delegate
        let newVC = T.viewControllerType().init()
        self.contentViewController = newVC
    }

    func lookup(_ word: String) {
        // TODO: Dictionary search
        let result = dic.lookUp(word)
        if let r = result {
            print("Result: " + r)
        } else {
            print("No result")
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
