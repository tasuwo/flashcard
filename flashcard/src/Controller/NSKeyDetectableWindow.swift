//
//  NSKeyDetectableWindow.swift
//  flashcard
//
//  Created by 兎澤　佑　 on 2017/06/22.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import Cocoa

class NSKeyDetectableWindow: NSWindow {
    override var canBecomeMain: Bool { return true }
    override var canBecomeKey: Bool { return true }
}
