//
//  UserDefaults+blankDefaultsWhile.swift
//  flashcard
//
//  Created by 兎澤　佑　 on 2017/06/27.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

extension UserDefaults {
    static func blankDefaultsWhile(handler: () -> Void) {
        guard let name = Bundle.main.bundleIdentifier else {
            fatalError("Couldn't find bundle ID.")
        }
        let old = UserDefaults.standard.persistentDomain(forName: name)
        defer {
            UserDefaults.standard.setPersistentDomain(old ?? [:], forName: name)
        }

        UserDefaults.standard.removePersistentDomain(forName: name)
        handler()
    }
}
