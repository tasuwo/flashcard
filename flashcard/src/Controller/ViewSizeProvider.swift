//
//  ViewSizeProvider.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/06/21.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation

protocol ViewSizeProvider {
    static func size() -> NSSize
}

extension ViewSizeProvider where Self: PlayCardViewController {
    static func size() -> NSSize {
        return NSSize(width: 400, height: 300)
    }
}

extension ViewSizeProvider where Self: EditCardViewController {
    static func size() -> NSSize {
        return NSSize(width: 800, height: 450)
    }
}

extension ViewSizeProvider where Self: SearchViewController {
    static func size() -> NSSize {
        return NSSize(width: 800, height: 60)
    }
}
