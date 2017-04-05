//
//  AppSettings.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/26.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import Magnet

class AppSettings: NSObject, NSCoding {
    var searchKeyCombo: KeyCombo?
    var playKeyCombo: KeyCombo?
    private var _defaultHolderId: Int = 0
    var defaultHolderId: Int? {
        set {
            self._defaultHolderId = newValue ?? 0
        }
        get {
            if let _ = CardHolder.get(self._defaultHolderId) {}
            else {
                return 0
            }
            
            return self._defaultHolderId
        }
    }

    init (playKeyCombo: KeyCombo? = nil, searchKeyCombo: KeyCombo? = nil, defaultHolderId: Int? = nil) {
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
            defaultHolderId: defaultHolderId
        )
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.playKeyCombo, forKey: "playKeyCombo")
        aCoder.encode(self.searchKeyCombo, forKey: "searchKeyCombo")
        aCoder.encode(self.defaultHolderId, forKey: "defaultHolderId")
    }
}

extension AppSettings {
    func setHotKey() {
        let appDelegate = NSApplication.shared().delegate as! AppDelegate
        if let k = searchKeyCombo {
            HotKeyCenter.shared.unregisterHotKey(with: "Search")
            let hotKey = HotKey(identifier: "Search", keyCombo: k, target: appDelegate, action: #selector(appDelegate.toggleQuickWindow))
            hotKey.register()
        }
        if let k = playKeyCombo {
            HotKeyCenter.shared.unregisterHotKey(with: "Play")
            let hotKey = HotKey(identifier: "Play", keyCombo: k, target: appDelegate, action: #selector(appDelegate.togglePlayWindow))
            hotKey.register()
        }
    }

    func save() {
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self)
        UserDefaults.standard.set(encodedData, forKey: "AppSettings")
        UserDefaults.standard.synchronize()
    }
    
    class func get() -> AppSettings? {
        if let decoded = UserDefaults.standard.object(forKey: "AppSettings") as? Data,
           let settings = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? AppSettings {
            return settings
        }
        return nil
    }
}
