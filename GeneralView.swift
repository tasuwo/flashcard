//
//  GeneralView.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/21.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa
import Magnet
import KeyHolder

protocol GeneralViewDelegate : class {
    func didChangeText(_ text: String)
    func didPressEnter()
    func didMoveUp()
    func didMoveDown()
}

// MARK: -
class GeneralView : NSView {
    open var delegate : GeneralViewDelegate?
    var hotKeyField: NSTextField!
    var hotKeyFieldLabel: NSTextField!
    
    override init(frame: NSRect) {
        super.init(frame: frame)
        
        let recordView = RecordView()
        recordView.translatesAutoresizingMaskIntoConstraints = false
        recordView.tintColor = NSColor(red: 0.164, green: 0.517, blue: 0.823, alpha: 1)
        recordView.delegate = self
        self.addSubview(recordView)
        
        hotKeyFieldLabel = NSTextField()
        hotKeyFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        hotKeyFieldLabel.stringValue = "Hotkey:"
        hotKeyFieldLabel.isBezeled = false
        hotKeyFieldLabel.drawsBackground = false
        hotKeyFieldLabel.isEditable = false
        hotKeyFieldLabel.isSelectable = false
        self.addSubview(hotKeyFieldLabel)
        
        self.addConstraints([
            NSLayoutConstraint(item: self, attribute: .width,  relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frame.width),
            NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frame.height),

            NSLayoutConstraint(item: recordView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX,        multiplier: 1, constant: 0),
            NSLayoutConstraint(item: recordView, attribute: .top,     relatedBy: .equal, toItem: self, attribute: .top,            multiplier: 1, constant: 100),
            NSLayoutConstraint(item: recordView, attribute: .width,   relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 300),
            NSLayoutConstraint(item: recordView, attribute: .height,  relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 50),
            
            NSLayoutConstraint(item: hotKeyFieldLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX,        multiplier: 1, constant: -(300/2)),
            NSLayoutConstraint(item: hotKeyFieldLabel, attribute: .top,     relatedBy: .equal, toItem: self, attribute: .top,            multiplier: 1, constant: 100),
            NSLayoutConstraint(item: hotKeyFieldLabel, attribute: .width,   relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 100),
            NSLayoutConstraint(item: hotKeyFieldLabel, attribute: .height,  relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 50),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GeneralView : RecordViewDelegate {
    func recordViewShouldBeginRecording(_ recordView: RecordView) -> Bool {
        return true
    }
    
    func recordView(_ recordView: RecordView, canRecordKeyCombo keyCombo: KeyCombo) -> Bool {
        // You can customize validation
        return true
    }
    
    func recordViewDidClearShortcut(_ recordView: RecordView) {
        HotKeyCenter.shared.unregisterHotKey(with: "KeyHolderExample")
    }
    
    func recordViewDidEndRecording(_ recordView: RecordView) {
    }
    
    func recordView(_ recordView: RecordView, didChangeKeyCombo keyCombo: KeyCombo) {
        HotKeyCenter.shared.unregisterHotKey(with: "KeyHolderExample")
        let hotKey = HotKey(identifier: "KeyHolderExample", keyCombo: keyCombo, target: self, action: #selector(GeneralView.didHotkeyPressed(_:)))
        hotKey.register()
    }
    
    func didHotkeyPressed (_ event: NSEvent) -> Void {
        let appDelegate = NSApplication.shared().delegate as? AppDelegate
        appDelegate?.toggleQuickWindow()
    }
}

