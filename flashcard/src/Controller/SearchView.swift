//
//  SearchView.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/04.
//  Copyright © 2017 tasuku tozawa. All rights reserved.
//

import Cocoa

class SearchView : NSView {
    var textField: NSTextField!
    
    override init(frame: NSRect) {
        super.init(frame: frame)
        
        textField = NSTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textField)
        
        self.addConstraints([
            NSLayoutConstraint(item: textField, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: textField, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: textField, attribute: .width,   relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 800),
            NSLayoutConstraint(item: textField, attribute: .height,  relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
