//
//  SettingsWindowController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/06.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

class SettingsWindowController : NSWindowController {
    static let winSize = NSSize(width: 800, height: 600)

    var toolbar : NSToolbar!
    var toolbarTabsArray = [
        ["title":"itemA", "icon":"NSFontPanel", "class":"ItemAViewController", "identifier":"ItemAViewController"],
        ["title":"itemB", "icon":"NSFontPanel", "class":"ItemBViewController", "identifier":"ItemBViewController"],
    ]
    var toolbarTabsIdentifierArray:[String] = []
    
    override init(window: NSWindow?) {
        super.init(window: window)
        
        let controller = SettingsViewController()
        let content = self.window!.contentView! as NSView
        let view = controller.view
        content.addSubview(view)

        // Toolbar
        for item in self.toolbarTabsArray {
            toolbarTabsIdentifierArray.append(item["identifier"]!)
        }
        toolbar = NSToolbar(identifier: "id")
        toolbar.allowsUserCustomization = true
        toolbar.delegate = self
        self.window?.toolbar = toolbar
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.delegate = self
    }
}

// MARK: - NSWindowDelegate
extension SettingsWindowController : NSWindowDelegate {
    func windowDidMiniaturize(_ notification: Notification) {
        print("Window minimized")
    }
    
    func windowWillClose(_ notification: Notification) {
        print("Window closing")
    }
}

// MARK: - NSToolbarDelegate
extension SettingsWindowController : NSToolbarDelegate {
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: String, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        // TODO : validation dictionary balues

        let results = toolbarTabsArray.filter({ $0["identifier"] == itemIdentifier })
        if results.count > 1 {
            // TODO: Error handling. There are dupricated identifiers
        } else if results.isEmpty {
            // TODO: Error handling. There are no identifiers
        }
        let itemInfo = results.first!

        let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
        toolbarItem.label = itemInfo["title"]!
        toolbarItem.image = NSImage(named: itemInfo["icon"]!)
        toolbarItem.target = self
        toolbarItem.action = #selector(SettingsWindowController.viewSelected(_:))
        
        return toolbarItem
    }

    func toolbarWillAddItem(_ notification: Notification) {
        print("toolbarWillAddItem")
    }

    func toolbarDidRemoveItem(_ notification: Notification) {
        print("toolbarDidRemoveItem")
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [String] {
        return self.toolbarDefaultItemIdentifiers(toolbar)
    }

    func toolbarSelectableItemIdentifiers(_ toolbar: NSToolbar) -> [String] {
        return self.toolbarDefaultItemIdentifiers(toolbar)
    }

    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [String] {
        return self.toolbarTabsIdentifierArray
    }
}

// MARK: - View Transition
extension SettingsWindowController {
    func viewSelected(_ sender: NSToolbarItem) {
        Swift.print(sender.itemIdentifier)
        
        // Transition by identifier
    }
}
