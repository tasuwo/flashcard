//
//  SettingsWindowToolbar.swift
//  flashcard
//
//  Created by 兎澤　佑　 on 2017/06/22.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import Cocoa

struct TabInfo {
    let title: String
    let icon: String
    let viewController: NSViewController.Type
}

class SettingsWindowToolbar: NSToolbar {
    var toolbarTabsArray = [
        TabInfo(title: "General", icon: "NSPreferencesGeneral", viewController: GeneralViewController.self),
        TabInfo(title: "Cards", icon: "NSAdvanced", viewController: CardsViewController.self),
    ]
    var toolbarTabsIdentifierArray: [String] = []

    override init(identifier: String) {
        super.init(identifier: identifier)

        for item in self.toolbarTabsArray {
            toolbarTabsIdentifierArray.append(item.viewController.className())
        }

        self.allowsUserCustomization = true
        self.delegate = self
    }

    func getViewControllerTypeBy(_ id: String) -> NSViewController.Type? {
        return ((self.toolbarTabsArray.filter { $0.viewController.className() == id }).first)?.viewController
    }
}

// MARK: - NSToolbarDelegate
extension SettingsWindowToolbar: NSToolbarDelegate {
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
