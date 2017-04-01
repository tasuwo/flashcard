//
//  String+removeInt.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/31.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation

extension String {
    func removeInt() -> String {
        var result: String = ""
        for char: Character in self.characters {
            guard Int(String(char)) != nil else {
                result.append(char)
                continue
            }
        }
        return result
    }
}
