//
//  GeneralViewControllerTests.swift
//  flashcard
//
//  Created by 兎澤　佑　 on 2017/06/27.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import XCTest
import Magnet
import KeyHolder
@testable import flashcard

class FakeCardHolderPresenterImpl: NSObject, CardHolderPresenter {
    func load(targetTableView: NSTableView) {}
    func getHolder(at row: Int) -> CardHolder? {
        if row == 0 {
            let holder = CardHolder(name: "default")
            holder.id = 1
            return holder
        }
        return nil
    }
}

class FakeAppSettingsImpl: NSObject, AppSettings {
    var settedKey: String?
    var settedKeyCombo: KeyCombo?
    var settedDefaultHolderId: Int?

    func setKeyCombo(_ key: String, value: KeyCombo?) throws {
        self.settedKey = key
        self.settedKeyCombo = value
    }
    func getKeyCombos() -> AppSettingsKeyCombos {
        return AppSettingsKeyCombos(search: nil, play: nil)
    }
    func setDefaultHolderId(_ id: Int) {
        self.settedDefaultHolderId = id
    }
    func getDefaultHolderId() throws -> Int {
        return 0
    }
}

class GeneralViewControllerTests: XCTestCase {
    var fakeSettings: FakeAppSettingsImpl!
    var vc: GeneralViewController!

    override func setUp() {
        super.setUp()
        
        self.fakeSettings = FakeAppSettingsImpl()
        self.vc = GeneralViewController(presenter: FakeCardHolderPresenterImpl(), appSettings: fakeSettings)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // カードホルダー選択時に、それを登録できる
    func testSelectDefaultCardHolder() {
        self.vc.didSelectDefaultHolder(row: 0)
        XCTAssertTrue(fakeSettings.settedDefaultHolderId == 1)
    }
    
    // ホットキー入力時に、それを登録できる
    func testRegistHotKey() {
        let playId = "play"
        let playRecordView = RecordView()
        playRecordView.identifier = playId
        let playKeyCombo = KeyCombo(doubledCocoaModifiers: .command)!
        self.vc.recordView(playRecordView, didChangeKeyCombo: playKeyCombo)
        
        XCTAssertTrue(playKeyCombo === fakeSettings.settedKeyCombo)
        XCTAssertTrue(playId == fakeSettings.settedKey)
    }
    
    // ホットキークリアー時に、それを登録できる
    func testClearHotKey() {
        let playId = "play"
        let playRecordView = RecordView()
        playRecordView.identifier = playId
        let playKeyCombo = KeyCombo(doubledCocoaModifiers: .command)!
        self.vc.recordView(playRecordView, didChangeKeyCombo: playKeyCombo)
        
        XCTAssertTrue(playKeyCombo === fakeSettings.settedKeyCombo)
        XCTAssertTrue(playId == fakeSettings.settedKey)
        
        self.vc.recordViewDidClearShortcut(playRecordView)
        
        XCTAssertTrue(nil === fakeSettings.settedKeyCombo)
        XCTAssertTrue(playId == fakeSettings.settedKey)
    }
}
