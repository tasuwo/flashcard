//
//  GeneralView.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/21.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

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
        
        hotKeyField = NSTextField()
        hotKeyField.translatesAutoresizingMaskIntoConstraints = false
        hotKeyField.focusRingType = .none
        self.addSubview(hotKeyField)
        
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

            NSLayoutConstraint(item: hotKeyField, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX,        multiplier: 1, constant: 0),
            NSLayoutConstraint(item: hotKeyField, attribute: .top,     relatedBy: .equal, toItem: self, attribute: .top,            multiplier: 1, constant: 100),
            NSLayoutConstraint(item: hotKeyField, attribute: .width,   relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 300),
            NSLayoutConstraint(item: hotKeyField, attribute: .height,  relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 50),
            
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

