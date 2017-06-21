//
//  SettingsWindowController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/06.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

class SettingsWindowController: NSWindowController {
    var toolbar: SettingsWindowToolbar!

    override init(window: NSWindow?) {
        super.init(window: window)

        toolbar = SettingsWindowToolbar(identifier: "id")
        self.window!.toolbar = toolbar

        let controller = GeneralViewController()
        self.window!.contentViewController = controller
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - WindowSizeCalculator
extension SettingsWindowController: WindowSizeCalculator {}

// MARK: - View Transition
extension SettingsWindowController {
    func viewSelected(_ sender: NSToolbarItem) {
        self.loadViewWithIdentifier(sender.itemIdentifier)
    }

    func loadViewWithIdentifier(_ id: String) {
        if self.contentViewController!.className == id { return }

        if let type = self.toolbar.getViewControllerTypeBy(id) {
            let newViewController = type.init()
            self.window!.contentViewController = newViewController
        }
    }
}
