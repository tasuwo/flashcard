//
//  flashcardUITests.swift
//  flashcardUITests
//
//  Created by 兎澤　佑　 on 2017/06/27.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import XCTest
import RealmSwift

class flashcardUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let app = XCUIApplication()
        XCTAssertTrue(app.windows.allElementsBoundByIndex.count == 0)
        
        let menuBarItem = app.menuBarItems.element(boundBy: 0)
        menuBarItem.click()
        
        let prefItem = app.menuItems.allElementsBoundByIndex.filter({ elem in elem.title == "Preferences"})
        XCTAssertTrue(prefItem.count == 1)
        prefItem.first!.click()
        
        XCTAssertTrue(app.windows.allElementsBoundByIndex.count == 1)
        // let settingsWindow = app.windows.element(boundBy: 0)
    }
    
}
