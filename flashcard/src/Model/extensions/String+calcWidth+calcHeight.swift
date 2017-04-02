//
//  String+calcWidth+calcHeight.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/04/02.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import Cocoa

extension String {
    func calcWidth() -> CGFloat {
        return NSAttributedString(string: self, attributes: [NSFontAttributeName: NSFont.systemFont(ofSize: NSFont.systemFontSize())]).size().width
    }
    
    func calcHeight() -> CGFloat {
        return NSAttributedString(string: self, attributes: [NSFontAttributeName: NSFont.systemFont(ofSize: NSFont.systemFontSize())]).size().height
    }
}
