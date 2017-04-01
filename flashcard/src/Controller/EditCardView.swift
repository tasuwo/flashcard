//
//  EditCardView.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/10.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import Cocoa
import WebKit

protocol EditCardViewDelegate {
    func updateCardText(front: String, back: String)
    func cancel()
    func didPressCommandEnter()
}

class EditCardView : NSView {
    var targetWord: String = "" {
        didSet {
            self.frontTextField.stringValue = targetWord
        }
    }
    var definition: String = "" {
        didSet {
            self.definitionField.mainFrame.loadHTMLString(CoreServiceDictionary.parseToHTML(self.definition), baseURL: nil)
        }
    }
    fileprivate var definitionField: WebView!
    fileprivate var frontTextField: NSTextField!
    fileprivate var backTextField: NSTextField!
    open var delegate: EditCardViewDelegate!
    override var acceptsFirstResponder: Bool {
        return true
    }
    
    override init(frame: NSRect) {
        super.init(frame: frame)
        
        definitionField = WebView()
        frontTextField = NSTextField()
        backTextField  = NSTextField()
        definitionField.isEditable = false
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
            NSLayoutConstraint(item: definitionField, attribute: .width,   relatedBy: .equal, toItem: self, attribute: .width,   multiplier: 0.5, constant: (-10 + -5)),

            NSLayoutConstraint(item: frontTextField, attribute: .top,     relatedBy: .equal, toItem: self, attribute: .top,     multiplier: 1,   constant: 10),
            NSLayoutConstraint(item: frontTextField, attribute: .right,   relatedBy: .equal, toItem: self, attribute: .right,   multiplier: 1,   constant: -10),
            NSLayoutConstraint(item: frontTextField, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 0.5, constant: 0),
            NSLayoutConstraint(item: frontTextField, attribute: .width,   relatedBy: .equal, toItem: self, attribute: .width,   multiplier: 0.5, constant: (-10 + -5)),
            NSLayoutConstraint(item: frontTextField, attribute: .height,  relatedBy: .equal, toItem: self, attribute: .height,  multiplier: 0.5, constant: (-10 + -5)),

            NSLayoutConstraint(item: backTextField, attribute: .bottom,  relatedBy: .equal, toItem: self, attribute: .bottom,  multiplier: 1,   constant: -10),
            NSLayoutConstraint(item: backTextField, attribute: .right,   relatedBy: .equal, toItem: self, attribute: .right,   multiplier: 1,   constant: -10),
            NSLayoutConstraint(item: backTextField, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.5, constant: 0),
            NSLayoutConstraint(item: backTextField, attribute: .width,   relatedBy: .equal, toItem: self, attribute: .width,   multiplier: 0.5, constant: (-10 + -5)),
            NSLayoutConstraint(item: backTextField, attribute: .height,  relatedBy: .equal, toItem: self, attribute: .height,  multiplier: 0.5, constant: (-10 + -5))
            ])
        
        frontTextField.delegate = self
        backTextField.delegate = self
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
    
    func setResponder() {
        self.backTextField.becomeFirstResponder()
        self.frontTextField.nextKeyView = self.backTextField
        self.backTextField.nextKeyView = self.frontTextField
    }
}

let EnterKeyCode: UInt16 = 36

// MARK: - NSTextFieldDelegate
extension EditCardView : NSTextFieldDelegate {
    override func controlTextDidChange(_ obj: Notification) {
        self.delegate.updateCardText(front: self.frontTextField.stringValue, back: self.backTextField.stringValue)
    }

    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if let event = NSApp.currentEvent {
            if (event.modifierFlags.rawValue & NSEventModifierFlags.command.rawValue) != 0
               && event.keyCode == EnterKeyCode {
                self.delegate?.didPressCommandEnter()
                return true
            }
        }

        if commandSelector == #selector(NSResponder.insertNewline(_:)) {
            control.stringValue = control.stringValue.appending("\n")
            return true
        } else if commandSelector == #selector(NSResponder.cancelOperation(_:)) {
            self.delegate?.cancel()
            return true
        }
        return false
    }
}
