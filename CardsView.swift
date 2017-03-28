//
//  CardsView.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/22.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

class CardsView : NSView {
    var sideBar: NSScrollView!
    var holders: NSTableView!
    var editCardSpace: NSView!
    var model: fakeModel!

    override init(frame: NSRect) {
        super.init(frame: frame)
        
        holders = NSTableView()
        holders.translatesAutoresizingMaskIntoConstraints = true
        holders.delegate = self
        model = fakeModel()
        holders.dataSource = model
        holders.focusRingType = .none
        holders.columnAutoresizingStyle = .uniformColumnAutoresizingStyle
        holders.headerView = nil
        
        let column = NSTableColumn(identifier: "test")
        column.resizingMask = .autoresizingMask
        column.sizeToFit()

        holders.addTableColumn(column)
        holders.reloadData()
        holders.sizeLastColumnToFit()
        
        sideBar = NSScrollView()
        sideBar.translatesAutoresizingMaskIntoConstraints = false
        sideBar.documentView = holders
        self.addSubview(sideBar)
        
        editCardSpace = NSView()
        editCardSpace.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(editCardSpace)
        
        self.addConstraints([
            NSLayoutConstraint(item: self, attribute: .width,  relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frame.width),
            NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frame.height),
            
            NSLayoutConstraint(item: sideBar, attribute: .top,    relatedBy: .equal, toItem: self, attribute: .top,            multiplier: 1, constant: 0),
            NSLayoutConstraint(item: sideBar, attribute: .left,   relatedBy: .equal, toItem: self, attribute: .left,           multiplier: 1, constant: 0),
            NSLayoutConstraint(item: sideBar, attribute: .width,  relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 250),
            NSLayoutConstraint(item: sideBar, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height,         multiplier: 1, constant: 0),
            
            NSLayoutConstraint(item: editCardSpace, attribute: .top,    relatedBy: .equal, toItem: self, attribute: .top,    multiplier: 1, constant: 0),
            NSLayoutConstraint(item: editCardSpace, attribute: .left,   relatedBy: .equal, toItem: self, attribute: .left,   multiplier: 1, constant: 250),
            NSLayoutConstraint(item: editCardSpace, attribute: .width,  relatedBy: .equal, toItem: self, attribute: .width,  multiplier: 1, constant: -250),
            NSLayoutConstraint(item: editCardSpace, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardsView: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var result = tableView.make(withIdentifier: "test", owner: nil) as? NSTextField
        
        if result == nil {
            result = NSTextField()
            result!.isBordered = false
            result!.drawsBackground = false
            result!.isBezeled = false
            result!.isEditable = false
            result!.identifier = "test"
        }
        
        return result
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 50
    }
}

class fakeModel: NSObject, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 100
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return "aaa"
    }
}
