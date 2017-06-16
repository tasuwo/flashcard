//
//  QuickWindowViewType.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/10.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

enum QuickWindowViewType {
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

    func type() -> NSView.Type {
        switch self {
        case .search:
            return SearchView.self
        case .editCard:
            return EditCardView.self
        }
    }

    func viewControllerType() -> QuickWindowViewController.Type {
        switch self {
        case .search:
            return SearchViewController.self
        case .editCard:
            return EditCardViewController.self
        }
    }
}
