//
//  SettingsViewController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/06.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

class SettingsViewController: NSViewController {
    override func loadView() {
        let winSize = SettingsWindowController.winSize
        let view = SettingsView(frame: NSMakeRect(0,0,winSize.width, winSize.height))
        view.delegate = self
        self.view = view
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}

extension SettingsViewController : SettingsViewDelegate {}
