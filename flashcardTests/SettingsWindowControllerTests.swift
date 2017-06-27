//
//  SettingsWindowControllerTests.swift
//  flashcard
//
//  Created by 兎澤　佑　 on 2017/06/23.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import XCTest
import RealmSwift
@testable import flashcard

class SettingsWindowControllerTests: XCTestCase {
    var vc: SettingsWindowController!
    var toolbar: SettingsWindowToolbar!

    override func setUp() {
        super.setUp()
        
        self.vc = SettingsWindowController(window: InputableWindow(
            contentRect: SettingsWindowController.defaultRect(),
            styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView, .resizable],
            backing: .buffered,
            defer: false)
        )
        self.toolbar = self.vc.toolbar
        
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testViewChangingBySelectingToolbar() {
        let infos = self.toolbar.toolbarTabsArray
        
        for info in infos {
            let id = info.id
            let item = NSToolbarItem(itemIdentifier: id)
            
            self.vc.didSelectToolbarItem(item)

            XCTAssert(self.vc.contentViewController?.className == info.viewController.className())
        }
    }
}
