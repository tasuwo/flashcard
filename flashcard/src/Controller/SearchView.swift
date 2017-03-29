//
//  SearchView.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/04.
//  Copyright © 2017 tasuku tozawa. All rights reserved.
//

import Cocoa

protocol SearchViewDelegate : class {
    func didChangeText(_ text: String)
    func didPressEnter()
    func didMoveUp()
    func didMoveDown()
    func cancel()
}

// MARK: -
class SearchView : NSView {
    open var delegate : SearchViewDelegate?
    var textField: NSTextField!
    
    override init(frame: NSRect) {
        super.init(frame: frame)
        
        textField = NSTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.focusRingType = .none
        textField.isBezeled = false
        textField.drawsBackground = false
        textField.font = NSFont(name: textField.font!.fontName, size: 33)
        self.addSubview(textField)
        
        self.addConstraints([
            NSLayoutConstraint(item: textField, attribute: .left,    relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: textField, attribute: .top,     relatedBy: .equal, toItem: self, attribute: .top,  multiplier: 1, constant: 10),
            NSLayoutConstraint(item: textField, attribute: .width,   relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 800),
            NSLayoutConstraint(item: textField, attribute: .height,  relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 50),
        ])
        
        textField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        NSGraphicsContext.saveGraphicsState()
        super.draw(dirtyRect)
        
        NSColor.clear.set()
        NSRectFill(dirtyRect)
        
        let path = NSBezierPath(roundedRect: self.bounds, xRadius: 5, yRadius: 5)
        NSColor.windowBackgroundColor.set()
        path.fill()
        
        NSGraphicsContext.restoreGraphicsState()
    }
}

// MARK: - NSTextFieldDelegate
extension SearchView : NSTextFieldDelegate {
    override func controlTextDidChange(_ obj: Notification) {
        self.delegate?.didChangeText(self.textField.stringValue)
    }
    
    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if commandSelector == #selector(NSResponder.insertNewline(_:)) {
            self.delegate?.didPressEnter()
            return true
        } else if commandSelector == #selector(NSResponder.moveUp(_:)) {
            self.delegate?.didMoveUp()
            return true
        } else if commandSelector == #selector(NSResponder.moveDown(_:)) {
            self.delegate?.didMoveDown()
            return true
        } else if commandSelector == #selector(NSResponder.cancelOperation(_:)) {
            self.delegate?.cancel()
            return true
        }
        return false
    }
}
