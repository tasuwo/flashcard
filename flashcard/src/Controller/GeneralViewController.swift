//
//  GeneralViewController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/22.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

class GeneralViewController: NSViewController {
    override func loadView() {
        let winSize = SettingsWindowController.winSize
        let view = GeneralView(frame: NSMakeRect(0,0,winSize.width, winSize.height))
        
        self.view = view
    }
}
