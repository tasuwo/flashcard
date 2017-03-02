//
//  util.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/03.
//  Copyright © 2017 tasuku tozawa. All rights reserved.
//

import Foundation
import Cocoa

// TODO: Specify target screen
func getScreenSize() -> CGSize? {
    if let screens = NSScreen.screens(),
       let screen  = screens.first {
        return screen.frame.size
    }
    return nil
}
