//
//  SettingsView.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/06.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

protocol SettingsViewDelegate : class {}

class SettingsView : NSView {
    open var delegate : SettingsViewDelegate?
    
    override init(frame: NSRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
