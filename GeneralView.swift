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
    func didChangeHotKey(identifier: String, keyCombo: KeyCombo)
}

// MARK: -
class GeneralView : NSView {
    open var delegate : GeneralViewDelegate?
    var hotKeyField: NSTextField!
    var hotKeyFieldLabel: NSTextField!
    
    override init(frame: NSRect) {
        super.init(frame: frame)
        
        let searchHotKeyRecordView = RecordView()
        searchHotKeyRecordView.translatesAutoresizingMaskIntoConstraints = false
        searchHotKeyRecordView.tintColor = NSColor(red: 0.164, green: 0.517, blue: 0.823, alpha: 1)
        searchHotKeyRecordView.delegate = self
        if let settings = AppSettings.get(), let keycombo = settings.searchKeyCombo {
            searchHotKeyRecordView.keyCombo = keycombo
        }
        searchHotKeyRecordView.identifier = "Search"
        self.addSubview(searchHotKeyRecordView)
        
        let playHotKeyRecordView = RecordView()
        playHotKeyRecordView.translatesAutoresizingMaskIntoConstraints = false
        playHotKeyRecordView.tintColor = NSColor(red: 0.164, green: 0.517, blue: 0.823, alpha: 1)
        playHotKeyRecordView.delegate = self
        if let settings = AppSettings.get(), let keycombo = settings.playKeyCombo {
            playHotKeyRecordView.keyCombo = keycombo
        }
        playHotKeyRecordView.identifier = "Play"
        self.addSubview(playHotKeyRecordView)
        
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

            NSLayoutConstraint(item: searchHotKeyRecordView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX,        multiplier: 1, constant: 0),
            NSLayoutConstraint(item: searchHotKeyRecordView, attribute: .top,     relatedBy: .equal, toItem: self, attribute: .top,            multiplier: 1, constant: 100),
            NSLayoutConstraint(item: searchHotKeyRecordView, attribute: .width,   relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 300),
            NSLayoutConstraint(item: searchHotKeyRecordView, attribute: .height,  relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 50),
            
            NSLayoutConstraint(item: playHotKeyRecordView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX,        multiplier: 1, constant: 0),
            NSLayoutConstraint(item: playHotKeyRecordView, attribute: .top,     relatedBy: .equal, toItem: self, attribute: .top,            multiplier: 1, constant: 400),
            NSLayoutConstraint(item: playHotKeyRecordView, attribute: .width,   relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 300),
            NSLayoutConstraint(item: playHotKeyRecordView, attribute: .height,  relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 50),
            
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
        // TODO: Remove hot key and save it to userdefault
    }
    
    func recordViewDidEndRecording(_ recordView: RecordView) {
    }

    func recordView(_ recordView: RecordView, didChangeKeyCombo keyCombo: KeyCombo) {
        if let id = recordView.identifier {
            self.delegate?.didChangeHotKey(identifier: id, keyCombo: keyCombo)
        }
    }
}

