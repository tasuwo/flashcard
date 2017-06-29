//
//  AppSettings.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/26.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import Magnet

protocol AppSettings {
    func setKeyCombo(_ key: String, value: KeyCombo?) throws
    func getKeyCombos() -> AppSettingsKeyCombos
    func setDefaultHolderId(_: Int)
    func getDefaultHolderId() throws -> Int
}

enum AppSettingsError: Error {
    case NoSuchKey
    case NoAppDefaultHolder
}

struct AppSettingsKeyCombos {
    let search: KeyCombo?
    let play: KeyCombo?
}

class AppSettingsImpl: NSObject, NSCoding {
    fileprivate var searchKeyCombo: KeyCombo?
    fileprivate var playKeyCombo: KeyCombo?
    fileprivate var defaultHolderId: Int = 0

    init(playKeyCombo: KeyCombo? = nil, searchKeyCombo: KeyCombo? = nil, defaultHolderId: Int = 0) {
        super.init()
        self.playKeyCombo = playKeyCombo
        self.searchKeyCombo = searchKeyCombo
        self.defaultHolderId = defaultHolderId
    }

    required convenience init(coder aDecoder: NSCoder) {
        let playkeycombo = aDecoder.decodeObject(forKey: "playKeyCombo") as! KeyCombo?
        let searchkeycombo = aDecoder.decodeObject(forKey: "searchKeyCombo") as! KeyCombo?
        let defaultHolderId = aDecoder.decodeObject(forKey: "defaultHolderId") as! Int?
        self.init(
            playKeyCombo: playkeycombo,
            searchKeyCombo: searchkeycombo,
            defaultHolderId: defaultHolderId ?? 0
        )
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.playKeyCombo, forKey: "playKeyCombo")
        aCoder.encode(self.searchKeyCombo, forKey: "searchKeyCombo")
        aCoder.encode(self.defaultHolderId, forKey: "defaultHolderId")
    }

    fileprivate func save() {
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self)
        UserDefaults.standard.set(encodedData, forKey: "AppSettings")
        UserDefaults.standard.synchronize()
    }

    func applyHotKeys() {
        let appDelegate = NSApplication.shared().delegate as! AppDelegate
        HotKeyCenter.shared.unregisterHotKey(with: "Search")
        HotKeyCenter.shared.unregisterHotKey(with: "Play")

        if let k = searchKeyCombo {
            let hotKey = HotKey(identifier: "Search", keyCombo: k, target: appDelegate, action: #selector(appDelegate.toggleQuickWindow))
            hotKey.register()
        }
        if let k = playKeyCombo {
            let hotKey = HotKey(identifier: "Play", keyCombo: k, target: appDelegate, action: #selector(appDelegate.togglePlayWindow))
            hotKey.register()
        }
    }
}

extension AppSettingsImpl: AppSettings {
    func setKeyCombo(_ key: String, value: KeyCombo?) throws {
        switch key {
        case "Play":
            self.playKeyCombo = value
        case "Search":
            self.searchKeyCombo = value
        default:
            throw AppSettingsError.NoSuchKey
        }
        applyHotKeys()
        save()
    }

    func getKeyCombos() -> AppSettingsKeyCombos {
        return AppSettingsKeyCombos(search: self.searchKeyCombo, play: self.playKeyCombo)
    }

    func setDefaultHolderId(_ id: Int) {
        self.defaultHolderId = id
        save()
    }

    func getDefaultHolderId() throws -> Int {
        if let _ = CardHolder.get(defaultHolderId) {
            return defaultHolderId
        }

        guard let _ = CardHolder.get(0) else {
            throw AppSettingsError.NoAppDefaultHolder
        }
        self.defaultHolderId = 0

        return 0
    }

    class func get() -> AppSettingsImpl? {
        if let decoded = UserDefaults.standard.object(forKey: "AppSettings") as? Data,
            let settings = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? AppSettingsImpl {
            return settings
        }
        return nil
    }
}
