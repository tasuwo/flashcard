//
//  EditCardView.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/10.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import Cocoa

class EditCardView : NSView {
    var frontTextField: NSTextField!
    var backTextField: NSTextField!
    
    override init(frame: NSRect) {
        super.init(frame: frame)
        
        frontTextField = NSTextField()
        backTextField  = NSTextField()
        
        frontTextField.translatesAutoresizingMaskIntoConstraints = false
        backTextField.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(frontTextField)
        self.addSubview(backTextField)
        
        self.addConstraints([
            NSLayoutConstraint(item: frontTextField, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: frontTextField, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: frontTextField, attribute: .width,   relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 800),
            NSLayoutConstraint(item: frontTextField, attribute: .height,  relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: backTextField, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backTextField, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 2, constant: 0),
            NSLayoutConstraint(item: backTextField, attribute: .width,   relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 800),
            NSLayoutConstraint(item: backTextField, attribute: .height,  relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 50)
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
    }
}
