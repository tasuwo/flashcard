//
//  EditCardView.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/10.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import Cocoa

protocol EditCardViewDelegate {
    func didPressEnter()
    func updateCardText(front: String, back: String)
}

class EditCardView : NSView {
    var definition: String = "" {
        didSet {
            self.definitionField.stringValue = self.definition
        }
    }
    fileprivate var definitionField: NSTextField!
    fileprivate var frontTextField: NSTextField!
    fileprivate var backTextField: NSTextField!
    open var delegate: EditCardViewDelegate!
    
    override init(frame: NSRect) {
        super.init(frame: frame)
        
        definitionField = NSTextField()
        frontTextField = NSTextField()
        backTextField  = NSTextField()
        definitionField.isEditable = false
        definitionField.focusRingType = .none
        frontTextField.focusRingType = .none
        backTextField.focusRingType = .none
        definitionField.translatesAutoresizingMaskIntoConstraints = false
        frontTextField.translatesAutoresizingMaskIntoConstraints = false
        backTextField.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(frontTextField)
        self.addSubview(backTextField)
        self.addSubview(definitionField)
        
        self.addConstraints([
            NSLayoutConstraint(item: self, attribute: .width,  relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frame.width),
            NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frame.height),
            
            NSLayoutConstraint(item: definitionField, attribute: .bottom,  relatedBy: .equal, toItem: self, attribute: .bottom,  multiplier: 1,   constant: -10),
            NSLayoutConstraint(item: definitionField, attribute: .top,     relatedBy: .equal, toItem: self, attribute: .top,     multiplier: 1,   constant: 10),
            NSLayoutConstraint(item: definitionField, attribute: .left,    relatedBy: .equal, toItem: self, attribute: .left,    multiplier: 1,   constant: 10),
            NSLayoutConstraint(item: definitionField, attribute: .width,   relatedBy: .equal, toItem: self, attribute: .width,   multiplier: 0.5, constant: -10),

            NSLayoutConstraint(item: frontTextField, attribute: .top,     relatedBy: .equal, toItem: self, attribute: .top,            multiplier: 1,   constant: 10),
            NSLayoutConstraint(item: frontTextField, attribute: .right,   relatedBy: .equal, toItem: self, attribute: .right,          multiplier: 1,   constant: -10),
            NSLayoutConstraint(item: frontTextField, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY,        multiplier: 0.5, constant: 0),
            NSLayoutConstraint(item: frontTextField, attribute: .width,   relatedBy: .equal, toItem: self, attribute: .width,          multiplier: 0.5, constant: -10),
            NSLayoutConstraint(item: frontTextField, attribute: .height,  relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1,   constant: 120),

            NSLayoutConstraint(item: backTextField, attribute: .bottom,  relatedBy: .equal, toItem: self, attribute: .bottom,         multiplier: 1,   constant: -10),
            NSLayoutConstraint(item: backTextField, attribute: .right,   relatedBy: .equal, toItem: self, attribute: .right,          multiplier: 1,   constant: -10),
            NSLayoutConstraint(item: backTextField, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY,        multiplier: 1.5, constant: 0),
            NSLayoutConstraint(item: backTextField, attribute: .width,   relatedBy: .equal, toItem: self, attribute: .width,          multiplier: 0.5, constant: -10),
            NSLayoutConstraint(item: backTextField, attribute: .height,  relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1,   constant: 120)
            ])
        
        frontTextField.delegate = self
        backTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - NSTextFieldDelegate
extension EditCardView : NSTextFieldDelegate {
    override func controlTextDidChange(_ obj: Notification) {
        self.delegate.updateCardText(front: self.frontTextField.stringValue, back: self.backTextField.stringValue)
    }

    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if commandSelector == #selector(NSResponder.insertNewline(_:)) {
            self.delegate?.didPressEnter()
            return true
        }
        return false
    }
}
