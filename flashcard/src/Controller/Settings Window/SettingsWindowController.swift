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
        toolbar.delegate = self
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
    func didSelectToolbarItem(_ sender: NSToolbarItem) {
        if self.contentViewController!.className == sender.itemIdentifier { return }

        if let type = self.toolbar.getViewControllerTypeBy(sender.itemIdentifier) {
            let newViewController = type.init()
            self.window!.contentViewController = newViewController
        }
    }
}

// MARK: - NSToolbarDelegate
extension SettingsWindowController: NSToolbarDelegate {
    func toolbar(_: NSToolbar, itemForItemIdentifier itemIdentifier: String, willBeInsertedIntoToolbar _: Bool) -> NSToolbarItem? {
        if let info = (self.toolbar.toolbarTabsArray.filter { $0.viewController.className() == itemIdentifier }).first {
            let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.label = info.title
            toolbarItem.image = NSImage(named: info.icon)
            toolbarItem.target = self
            toolbarItem.action = #selector(SettingsWindowController.didSelectToolbarItem(_:))

            return toolbarItem
        }
        return nil
    }

    func toolbarWillAddItem(_: Notification) {
        print("toolbarWillAddItem")
    }

    func toolbarDidRemoveItem(_: Notification) {
        print("toolbarDidRemoveItem")
    }

    func toolbarAllowedItemIdentifiers(_: NSToolbar) -> [String] {
        return self.toolbar.toolbarTabsIdentifierArray
    }

    func toolbarSelectableItemIdentifiers(_: NSToolbar) -> [String] {
        return self.toolbar.toolbarTabsIdentifierArray
    }

    func toolbarDefaultItemIdentifiers(_: NSToolbar) -> [String] {
        return self.toolbar.toolbarTabsIdentifierArray
    }
}
