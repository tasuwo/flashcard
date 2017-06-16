//
//  SettingsWindowController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/06.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

struct TabInfo {
    let title: String
    let icon: String
    let viewController: NSViewController.Type
}

class SettingsWindowController: NSWindowController {
    static let winSize = NSSize(width: 800, height: 600)

    var toolbar: NSToolbar!
    var toolbarTabsArray = [
        TabInfo(title: "General", icon: "NSPreferencesGeneral", viewController: GeneralViewController.self),
        TabInfo(title: "Cards", icon: "NSAdvanced", viewController: CardsViewController.self),
    ]
    var toolbarTabsIdentifierArray: [String] = []

    override init(window: NSWindow?) {
        super.init(window: window)

        // Toolbar
        for item in self.toolbarTabsArray {
            toolbarTabsIdentifierArray.append(item.viewController.className())
        }
        toolbar = NSToolbar(identifier: "id")
        toolbar.allowsUserCustomization = true
        toolbar.delegate = self
        self.window!.toolbar = toolbar

        // View Controller
        let controller = GeneralViewController()
        self.window!.contentViewController = controller
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - NSToolbarDelegate
extension SettingsWindowController: NSToolbarDelegate {
    func toolbar(_: NSToolbar, itemForItemIdentifier itemIdentifier: String, willBeInsertedIntoToolbar _: Bool) -> NSToolbarItem? {
        if let info = (self.toolbarTabsArray.filter { $0.viewController.className() == itemIdentifier }).first {
            let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.label = info.title
            toolbarItem.image = NSImage(named: info.icon)
            toolbarItem.target = self
            toolbarItem.action = #selector(SettingsWindowController.viewSelected(_:))

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

    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [String] {
        return self.toolbarDefaultItemIdentifiers(toolbar)
    }

    func toolbarSelectableItemIdentifiers(_ toolbar: NSToolbar) -> [String] {
        return self.toolbarDefaultItemIdentifiers(toolbar)
    }

    func toolbarDefaultItemIdentifiers(_: NSToolbar) -> [String] {
        return self.toolbarTabsIdentifierArray
    }
}

// MARK: - View Transition
extension SettingsWindowController {
    func viewSelected(_ sender: NSToolbarItem) {
        self.loadViewWithIdentifier(sender.itemIdentifier)
    }

    func loadViewWithIdentifier(_ id: String) {
        if self.contentViewController!.className == id { return }

        if let info = (self.toolbarTabsArray.filter { $0.viewController.className() == id }).first {
            let newViewController = info.viewController.init()
            self.window!.contentViewController = newViewController
        }
    }
}
