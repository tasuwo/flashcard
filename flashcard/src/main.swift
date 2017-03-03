//
//  main.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/03.
//  Copyright © 2017 tasuku tozawa. All rights reserved.
//

import Foundation
import Cocoa

// alloc main app's delegate class
let delegate = AppDelegate()
// set as app's delegate
NSApplication.shared().delegate = delegate

// Start of run loop
NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
