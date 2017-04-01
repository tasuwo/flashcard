//
//  Array+canAccess.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/04/01.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation

extension Array {
    func canAccess(index: Int) -> Bool {
        return self.count-1 >= index
    }
}
