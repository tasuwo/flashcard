//
//  NSRange+contain.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/21.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation

extension NSRange {
    func contain(_ i: Int) -> Bool {
        return (i >= self.location && i <= self.location+self.length-1)
    }
}
