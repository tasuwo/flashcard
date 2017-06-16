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

class EditCardView: NSView {
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
    fileprivate var textView: NSView!
    fileprivate var frontTextField: NSTextField!
    fileprivate var backTextField: NSTextField!
    open var delegate: EditCardViewDelegate!
    override var acceptsFirstResponder: Bool {
        return true
    }

    override init(frame: NSRect) {
        super.init(frame: frame)

        definitionField = WebView()
        definitionField.wantsLayer = true
        definitionField.isEditable = false
        definitionField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(definitionField)

        textView = NSView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textView)

        let BezelSize: CGFloat = 20
        let labelSize: CGFloat = 25
        self.addConstraints([
            NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frame.width),
            NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frame.height),

            NSLayoutConstraint(item: definitionField, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: (-1 * BezelSize)),
            NSLayoutConstraint(item: definitionField, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: BezelSize),
            NSLayoutConstraint(item: definitionField, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: BezelSize),
            NSLayoutConstraint(item: definitionField, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: (-1 * BezelSize + -1 * (BezelSize / 2))),

            NSLayoutConstraint(item: textView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: BezelSize),
            NSLayoutConstraint(item: textView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -1 * BezelSize),
            NSLayoutConstraint(item: textView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: (-1 * BezelSize + -1 * (BezelSize / 2))),
            NSLayoutConstraint(item: textView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: (-1 * BezelSize * 2)),
        ])

        let frontTextView = NSView()
        frontTextView.translatesAutoresizingMaskIntoConstraints = false
        textView.addSubview(frontTextView)

        let backTextView = NSView()
        backTextView.translatesAutoresizingMaskIntoConstraints = false
        textView.addSubview(backTextView)

        textView.addConstraints([
            NSLayoutConstraint(item: frontTextView, attribute: .top, relatedBy: .equal, toItem: textView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: frontTextView, attribute: .left, relatedBy: .equal, toItem: textView, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: frontTextView, attribute: .width, relatedBy: .equal, toItem: textView, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: frontTextView, attribute: .height, relatedBy: .equal, toItem: textView, attribute: .height, multiplier: 0.5, constant: 0),

            NSLayoutConstraint(item: backTextView, attribute: .bottom, relatedBy: .equal, toItem: textView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backTextView, attribute: .left, relatedBy: .equal, toItem: textView, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backTextView, attribute: .width, relatedBy: .equal, toItem: textView, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backTextView, attribute: .height, relatedBy: .equal, toItem: textView, attribute: .height, multiplier: 0.5, constant: 0),
        ])

        let frontTextLabel = myTextLabel(with: "Front")
        frontTextLabel.translatesAutoresizingMaskIntoConstraints = false
        frontTextLabel.alignment = .left
        frontTextLabel.font = NSFont.systemFont(ofSize: 18)
        frontTextView.addSubview(frontTextLabel)

        frontTextField = NSTextField()
        frontTextField.focusRingType = .none
        frontTextField.translatesAutoresizingMaskIntoConstraints = false
        frontTextView.addSubview(frontTextField)

        frontTextView.addConstraints([
            NSLayoutConstraint(item: frontTextLabel, attribute: .top, relatedBy: .equal, toItem: frontTextView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: frontTextLabel, attribute: .left, relatedBy: .equal, toItem: frontTextView, attribute: .left, multiplier: 1, constant: 2),
            NSLayoutConstraint(item: frontTextLabel, attribute: .width, relatedBy: .equal, toItem: frontTextView, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: frontTextLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: labelSize),

            NSLayoutConstraint(item: frontTextField, attribute: .top, relatedBy: .equal, toItem: frontTextView, attribute: .top, multiplier: 1, constant: labelSize),
            NSLayoutConstraint(item: frontTextField, attribute: .left, relatedBy: .equal, toItem: frontTextView, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: frontTextField, attribute: .width, relatedBy: .equal, toItem: frontTextView, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: frontTextField, attribute: .height, relatedBy: .equal, toItem: frontTextView, attribute: .height, multiplier: 1, constant: -1 * (labelSize + BezelSize / 2)),
        ])

        let backTextLabel = myTextLabel(with: "Back")
        backTextLabel.translatesAutoresizingMaskIntoConstraints = false
        backTextLabel.alignment = .left
        backTextLabel.font = NSFont.systemFont(ofSize: 18)
        backTextView.addSubview(backTextLabel)

        backTextField = NSTextField()
        backTextField.focusRingType = .none
        backTextField.translatesAutoresizingMaskIntoConstraints = false
        backTextView.addSubview(backTextField)

        backTextView.addConstraints([
            NSLayoutConstraint(item: backTextLabel, attribute: .top, relatedBy: .equal, toItem: backTextView, attribute: .top, multiplier: 1, constant: BezelSize / 2),
            NSLayoutConstraint(item: backTextLabel, attribute: .left, relatedBy: .equal, toItem: backTextView, attribute: .left, multiplier: 1, constant: 2),
            NSLayoutConstraint(item: backTextLabel, attribute: .width, relatedBy: .equal, toItem: backTextView, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backTextLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: labelSize),

            NSLayoutConstraint(item: backTextField, attribute: .bottom, relatedBy: .equal, toItem: backTextView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backTextField, attribute: .left, relatedBy: .equal, toItem: backTextView, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backTextField, attribute: .width, relatedBy: .equal, toItem: backTextView, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backTextField, attribute: .height, relatedBy: .equal, toItem: backTextView, attribute: .height, multiplier: 1, constant: -1 * (labelSize + BezelSize / 2)),
        ])

        frontTextField.delegate = self
        backTextField.delegate = self
    }

    required init?(coder _: NSCoder) {
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

    override func viewWillDraw() {
        definitionField.layer!.borderColor = CGColor(red: 170 / 255, green: 170 / 255, blue: 170 / 255, alpha: 1)
        definitionField.layer!.borderWidth = 0.5
    }

    func setResponder() {
        self.backTextField.becomeFirstResponder()
        self.frontTextField.nextKeyView = self.backTextField
        self.backTextField.nextKeyView = self.frontTextField
    }
}

let EnterKeyCode: UInt16 = 36

// MARK: - NSTextFieldDelegate
extension EditCardView: NSTextFieldDelegate {
    override func controlTextDidChange(_: Notification) {
        self.delegate.updateCardText(front: self.frontTextField.stringValue, back: self.backTextField.stringValue)
    }

    func control(_ control: NSControl, textView _: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
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
        } else if commandSelector == #selector(NSResponder.insertTab(_:)) {
            if let textField = control as? NSTextField {
                var nextTextField: NSTextField
                if textField === self.frontTextField {
                    nextTextField = self.backTextField
                } else {
                    nextTextField = self.frontTextField
                }
                nextTextField.focusWithoutSelectText(self)
            }
            return true
        }
        return false
    }
}
