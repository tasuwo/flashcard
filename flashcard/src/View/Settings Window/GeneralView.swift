//
//  GeneralView.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/21.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa
import Magnet
import KeyHolder

// MARK: -
class GeneralView: NSView {
    open var hotkeyDelegate: RecordViewDelegate? {
        didSet {
            self.playHotKeyRecordView.delegate = self.hotkeyDelegate
            self.searchHotKeyRecordView.delegate = self.hotkeyDelegate
        }
    }

    fileprivate var defaultHolderScrollView: NSScrollView!
    fileprivate(set) var defaultHolderTableView: CardHolderTableView!
    fileprivate var defaultHolderLabel: myTextLabel!
    fileprivate var searchHotKeyRecordView: RecordView!
    fileprivate var searchHotKeyLabel: myTextLabel!
    fileprivate var playHotKeyRecordView: RecordView!
    fileprivate var playHotKeyLabel: myTextLabel!

    override init(frame: NSRect) {
        super.init(frame: frame)

        searchHotKeyRecordView = myRecordView(id: "Search")
        if let settings = AppSettingsImpl.get() {
            searchHotKeyRecordView.keyCombo = settings.getKeyCombos().play
        }
        self.addSubview(searchHotKeyRecordView)

        playHotKeyRecordView = myRecordView(id: "Play")
        if let settings = AppSettingsImpl.get() {
            playHotKeyRecordView.keyCombo = settings.getKeyCombos().play
        }
        self.addSubview(playHotKeyRecordView)

        searchHotKeyLabel = myTextLabel(with: "Search & Regist word Hotkey:")
        searchHotKeyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchHotKeyLabel)

        playHotKeyLabel = myTextLabel(with: "Play HotKey:")
        playHotKeyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(playHotKeyLabel)

        defaultHolderTableView = CardHolderTableView()
        defaultHolderTableView.translatesAutoresizingMaskIntoConstraints = true
        defaultHolderTableView.setupSettings()
        defaultHolderTableView.rowHeight = 20
        defaultHolderTableView.usesAlternatingRowBackgroundColors = true

        defaultHolderScrollView = NSScrollView()
        defaultHolderScrollView.translatesAutoresizingMaskIntoConstraints = false
        defaultHolderScrollView.documentView = defaultHolderTableView
        self.addSubview(defaultHolderScrollView)

        defaultHolderLabel = myTextLabel(with: "Default Card Holder:")
        defaultHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(defaultHolderLabel)

        self.addConstraints([
            NSLayoutConstraint(item: searchHotKeyRecordView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: searchHotKeyRecordView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 150),
            NSLayoutConstraint(item: searchHotKeyRecordView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300),
            NSLayoutConstraint(item: searchHotKeyRecordView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40),

            NSLayoutConstraint(item: playHotKeyRecordView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: playHotKeyRecordView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: (150 + 40 + 50)),
            NSLayoutConstraint(item: playHotKeyRecordView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300),
            NSLayoutConstraint(item: playHotKeyRecordView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40),

            NSLayoutConstraint(item: searchHotKeyLabel, attribute: .right, relatedBy: .equal, toItem: searchHotKeyRecordView, attribute: .left, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: searchHotKeyLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: (150 + 10)),
            NSLayoutConstraint(item: searchHotKeyLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200),
            NSLayoutConstraint(item: searchHotKeyLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50),

            NSLayoutConstraint(item: playHotKeyLabel, attribute: .right, relatedBy: .equal, toItem: playHotKeyRecordView, attribute: .left, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: playHotKeyLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: (150 + 40 + 50 + 10)),
            NSLayoutConstraint(item: playHotKeyLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200),
            NSLayoutConstraint(item: playHotKeyLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50),

            NSLayoutConstraint(item: defaultHolderScrollView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: defaultHolderScrollView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 330),
            NSLayoutConstraint(item: defaultHolderScrollView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 400),
            NSLayoutConstraint(item: defaultHolderScrollView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80),

            NSLayoutConstraint(item: defaultHolderLabel, attribute: .right, relatedBy: .equal, toItem: defaultHolderTableView, attribute: .left, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: defaultHolderLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 340),
            NSLayoutConstraint(item: defaultHolderLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200),
            NSLayoutConstraint(item: defaultHolderLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50),
        ])
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
