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
    func didChangeHotKey(_ keyCombo: KeyCombo) {
        HotKeyCenter.shared.unregisterHotKey(with: "KeyHolderExample")
        let hotKey = HotKey(identifier: "KeyHolderExample", keyCombo: keyCombo, target: self, action: #selector(GeneralViewController.didHotkeyPressed(_:)))
        hotKey.register()
        
        // Save settings
        if let settings = AppSettings.get() {
            settings.keyCombo = keyCombo
            settings.set()
        } else {
            let data = AppSettings(keyCombo: keyCombo)
            data.set()
        }
    }
    
    func didHotkeyPressed (_ event: NSEvent) -> Void {
        let appDelegate = NSApplication.shared().delegate as? AppDelegate
        appDelegate?.toggleQuickWindow()
    }
}
