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
    var keyCombo: KeyCombo!
    
    init (keyCombo: KeyCombo) {
        self.keyCombo = keyCombo
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let keycombo = aDecoder.decodeObject(forKey: "keyCombo") as! KeyCombo
        self.init(
            keyCombo: keycombo
        )
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.keyCombo, forKey: "keyCombo")
    }
}
