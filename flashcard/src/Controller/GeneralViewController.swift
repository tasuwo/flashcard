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
        var selector: Selector
        switch identifier {
        case "Play":
            selector = #selector(GeneralViewController.didPlayHotkeyPressed(_:))
        case "Search":
            selector = #selector(GeneralViewController.didSearchHotkeyPressed(_:))
        default:
            return
        }

        HotKeyCenter.shared.unregisterHotKey(with: identifier)
        let hotKey = HotKey(identifier: identifier, keyCombo: keyCombo, target: self, action: selector)
        hotKey.register()
        
        // Save settings
        if let settings = AppSettings.get() {
            switch identifier {
            case "Play":
                settings.playKeyCombo = keyCombo
            case "Search":
                settings.searchKeyCombo = keyCombo
            default:
                break
            }
            settings.set()
        } else {
            var playKeyCombo: KeyCombo? = nil
            var searchKeyCombo: KeyCombo? = nil
            switch identifier {
            case "Play":
                playKeyCombo = keyCombo
            case "Search":
                searchKeyCombo = keyCombo
            default:
                break
            }
            let data = AppSettings(playKeyCombo: playKeyCombo, searchKeyCombo: searchKeyCombo)
            data.set()
        }
    }
    
    func didPlayHotkeyPressed (_ event: NSEvent) -> Void {
        let appDelegate = NSApplication.shared().delegate as? AppDelegate
        appDelegate?.didSelectPlay()
    }
    
    func didSearchHotkeyPressed(_ event: NSEvent) -> Void {
        let appDelegate = NSApplication.shared().delegate as? AppDelegate
        appDelegate?.toggleQuickWindow()
    }
}
