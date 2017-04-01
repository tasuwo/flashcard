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
    var searchHotKeyLabel: myTextLabel!
    var playHotKeyLabel: myTextLabel!
    
    override init(frame: NSRect) {
        super.init(frame: frame)
        
        let searchHotKeyRecordView = myRecordView(id: "Search")
        searchHotKeyRecordView.delegate = self
        if let settings = AppSettings.get(), let keycombo = settings.searchKeyCombo {
            searchHotKeyRecordView.keyCombo = keycombo
        }
        self.addSubview(searchHotKeyRecordView)
        
        let playHotKeyRecordView = myRecordView(id: "Play")
        playHotKeyRecordView.delegate = self
        if let settings = AppSettings.get(), let keycombo = settings.playKeyCombo {
            playHotKeyRecordView.keyCombo = keycombo
        }
        self.addSubview(playHotKeyRecordView)
        
        searchHotKeyLabel = myTextLabel(with: "Search & Regist word Hotkey:")
        searchHotKeyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchHotKeyLabel)
        
        playHotKeyLabel = myTextLabel(with: "Play HotKey:")
        playHotKeyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(playHotKeyLabel)
        
        self.addConstraints([
            NSLayoutConstraint(item: searchHotKeyRecordView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX,        multiplier: 1, constant: 50),
            NSLayoutConstraint(item: searchHotKeyRecordView, attribute: .top,     relatedBy: .equal, toItem: self, attribute: .top,            multiplier: 1, constant: 150),
            NSLayoutConstraint(item: searchHotKeyRecordView, attribute: .width,   relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 300),
            NSLayoutConstraint(item: searchHotKeyRecordView, attribute: .height,  relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 40),
            
            NSLayoutConstraint(item: playHotKeyRecordView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX,        multiplier: 1, constant: 50),
            NSLayoutConstraint(item: playHotKeyRecordView, attribute: .top,     relatedBy: .equal, toItem: self, attribute: .top,            multiplier: 1, constant: (150 + 40 + 50)),
            NSLayoutConstraint(item: playHotKeyRecordView, attribute: .width,   relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 300),
            NSLayoutConstraint(item: playHotKeyRecordView, attribute: .height,  relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 40),
            
            NSLayoutConstraint(item: searchHotKeyLabel, attribute: .right,   relatedBy: .equal, toItem: searchHotKeyRecordView, attribute: .left, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: searchHotKeyLabel, attribute: .top,     relatedBy: .equal, toItem: self, attribute: .top,            multiplier: 1, constant: (150 + 10)),
            NSLayoutConstraint(item: searchHotKeyLabel, attribute: .width,   relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 200),
            NSLayoutConstraint(item: searchHotKeyLabel, attribute: .height,  relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 50),
            
            NSLayoutConstraint(item: playHotKeyLabel, attribute: .right,   relatedBy: .equal, toItem: playHotKeyRecordView, attribute: .left, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: playHotKeyLabel, attribute: .top,     relatedBy: .equal, toItem: self, attribute: .top,            multiplier: 1, constant: (150 + 40 + 50 + 10)),
            NSLayoutConstraint(item: playHotKeyLabel, attribute: .width,   relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 200),
            NSLayoutConstraint(item: playHotKeyLabel, attribute: .height,  relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 50),
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

