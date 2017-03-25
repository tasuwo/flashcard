//
//  StatusBarItemController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/25.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

class StatusBarController: NSObject {
    var view: StatusBarItem!
    
    override init() {
        super.init()
        self.view = StatusBarItem()
    }
}

