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
        TabInfo(title: "Cards", icon: "NSAdvanced", viewController: HoldersCardsViewController.self),
    ]
    var toolbarTabsIdentifierArray: [String] = []

    override init(identifier: String) {
        super.init(identifier: identifier)

        for item in self.toolbarTabsArray {
            toolbarTabsIdentifierArray.append(item.viewController.className())
        }

        self.allowsUserCustomization = true
    }

    func getViewControllerTypeBy(_ id: String) -> NSViewController.Type? {
        return ((self.toolbarTabsArray.filter { $0.viewController.className() == id }).first)?.viewController
    }
}
