//
//  GeneralViewController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/22.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa
import KeyHolder
import Magnet

class GeneralViewController: NSViewController {
    override func loadView() {
        let winSize = SettingsWindowController.winSize
        let view = GeneralView(frame: NSMakeRect(0,0,winSize.width, winSize.height))
        view.delegate = self
        
        self.view = view
    }
}

extension GeneralViewController: GeneralViewDelegate {
    func didChangeHotKey(identifier: String, keyCombo: KeyCombo) {
        let settings = AppSettings.get() ?? AppSettings(playKeyCombo: nil, searchKeyCombo: nil)
        switch identifier {
        case "Play":
            settings.playKeyCombo = keyCombo
        case "Search":
            settings.searchKeyCombo = keyCombo
        default:
            break
        }
        settings.setHotKey()
        settings.save()
    }
}