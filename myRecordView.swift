//
//  myRecordView.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/04/01.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import KeyHolder

class myRecordView: RecordView {
    convenience init(id: String) {
        self.init()
        self.identifier = id
        self.tintColor = NSColor(red: 0.164, green: 0.517, blue: 0.823, alpha: 1)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
