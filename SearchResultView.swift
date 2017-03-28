//
//  Search.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/11.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

class SearchResultView : NSView {
    open var delegate : SearchResultsViewDelegate?
    var label: NSTextField!
    
    open var isSelected: Bool = false {
        didSet {
            if isSelected {
                self.label.backgroundColor = NSColor.init(deviceRed: 60/255, green: 107/255, blue: 217/255, alpha: 1)
            } else {
                self.label.backgroundColor = NSColor.init(deviceRed: 235/255, green: 235/255, blue: 235/255, alpha: 1)
            }
        }
    }
    
    override init(frame: NSRect) {
        super.init(frame: frame)
        
        self.acceptsTouchEvents = true
        
        label = NSTextField()
        label.isEditable = false
        label.isBezeled = false
        label.cell!.wraps = true
        label.backgroundColor = NSColor.init(deviceRed: 235/255, green: 235/255, blue: 235/255, alpha: 1)   
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)

        let rvHeight = SearchViewController.getResultViewHeight()
        self.addConstraints([
            NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX,        multiplier: 1, constant: 0),
            NSLayoutConstraint(item: label, attribute: .top,     relatedBy: .equal, toItem: self, attribute: .top,            multiplier: 1, constant: 0),
            NSLayoutConstraint(item: label, attribute: .width,   relatedBy: .equal, toItem: self, attribute: .width,          multiplier: 1, constant: 0),
            NSLayoutConstraint(item: label, attribute: .height,  relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: rvHeight)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(_ text: String) {
        label.stringValue = text
    }
}

extension SearchResultView {
    override func touchesBegan(with event: NSEvent) {

    }
    
    override func touchesMoved(with event: NSEvent) {

    }
    
    override func touchesEnded(with event: NSEvent) {

    }
    
    override func scrollWheel(with event: NSEvent) {
        Swift.print(event)
    }
}
