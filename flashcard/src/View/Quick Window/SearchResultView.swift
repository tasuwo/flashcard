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
    var title: NSTextField!
    var body: NSTextField!
    
    open var isSelected: Bool = false {
        didSet {
            if isSelected {
                self.layer!.backgroundColor = CGColor(red: 60/255, green: 107/255, blue: 217/255, alpha: 1)
                self.title.textColor = .white
            } else {
                self.layer!.backgroundColor = CGColor.clear
                self.title.textColor = .black
            }
        }
    }
    
    override init(frame: NSRect) {
        super.init(frame: frame)
        
        self.acceptsTouchEvents = true
        self.wantsLayer = true
        self.layer!.frame = frame
        
        title = NSTextField()
        title.isEditable = false
        title.isBezeled = false
        title.drawsBackground = false
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = NSFont(name: title.font!.fontName, size: 20)
        self.addSubview(title)
        
        body = NSTextField()
        body.isEditable = false
        body.isBezeled = false
        body.drawsBackground = false
        body.cell!.wraps = false
        body.translatesAutoresizingMaskIntoConstraints = false
        body.textColor = .lightGray
        body.font = NSFont(name: body.font!.fontName, size: 12)
        self.addSubview(body)

        let rvHeight = SearchViewController.getResultViewHeight()
        self.addConstraints([
            NSLayoutConstraint(item: title, attribute: .left,    relatedBy: .equal, toItem: self, attribute: .left,           multiplier: 1, constant: 10),
            NSLayoutConstraint(item: title, attribute: .top,     relatedBy: .equal, toItem: self, attribute: .top,            multiplier: 1, constant: 3),
            NSLayoutConstraint(item: title, attribute: .width,   relatedBy: .equal, toItem: self, attribute: .width,          multiplier: 1, constant: 0),
            NSLayoutConstraint(item: title, attribute: .height,  relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: rvHeight/2),

            NSLayoutConstraint(item: body, attribute: .left,    relatedBy: .equal, toItem: self, attribute: .left,           multiplier: 1, constant: 10),
            NSLayoutConstraint(item: body, attribute: .top,     relatedBy: .equal, toItem: self, attribute: .top,            multiplier: 1, constant: (rvHeight/2+3)),
            NSLayoutConstraint(item: body, attribute: .width,   relatedBy: .equal, toItem: self, attribute: .width,          multiplier: 1, constant: -20),
            NSLayoutConstraint(item: body, attribute: .height,  relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: rvHeight/2)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDraw() {
        if self.isSelected {
            self.layer?.backgroundColor = CGColor(red: 60/255, green: 107/255, blue: 217/255, alpha: 1)
            self.title.textColor = .white
        }
    }
    
    func setText(_ titleStr: String, bodyStr: String) {
        title.stringValue = titleStr
        body.stringValue = bodyStr
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
