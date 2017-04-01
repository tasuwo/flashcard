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
    
    init (playKeyCombo: KeyCombo?, searchKeyCombo: KeyCombo?) {
        self.playKeyCombo = playKeyCombo
        self.searchKeyCombo = searchKeyCombo
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let playkeycombo = aDecoder.decodeObject(forKey: "playKeyCombo") as! KeyCombo?
        let searchkeycombo = aDecoder.decodeObject(forKey: "searchKeyCombo") as! KeyCombo?
        self.init(
            playKeyCombo: playkeycombo,
            searchKeyCombo: searchkeycombo
        )
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.playKeyCombo, forKey: "playKeyCombo")
        aCoder.encode(self.searchKeyCombo, forKey: "searchKeyCombo")
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
