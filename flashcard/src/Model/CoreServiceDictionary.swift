//
//  Dictionary.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/09.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

class CoreServiceDictionary {
    /*
    fileprivate let AppleGlobalDomainName = "Apple Global Domain"
    fileprivate let DictionaryServicesKey = "com.apple.DictionaryServices"
    fileprivate let ActiveDictionariesKey = "DCSActiveDictionaries"
    
    // Get shared defaults object
    fileprivate func userDefaults() -> UserDefaults {
        return UserDefaults.standard
    }

    // Get a dictionary containing the keys and values in the apple global domain.
    // Apple global domain is a persistent domain, contains a default dictionary setting.
    // You can see the keys and values in the domain by executing following command in the terminal.
    //
    // $ defaults read "Apple Global Domain"
    //
    fileprivate func globalDomain() -> [String : AnyObject]? {
        return userDefaults().persistentDomain(forName: AppleGlobalDomainName) as [String : AnyObject]?
    }

    // Get a dictionary containing the dictionary preferences.
    // The preferences is stored in a key "com.apple.DictionaryServices" in the Apple Global Domain.
    // However, if the user has never set default dictionary, the return value would be nil.
    fileprivate func dictionaryPreferences() -> [AnyHashable: Any]? {
        return globalDomain()?[DictionaryServicesKey] as! [AnyHashable: Any]?
    }
    
    fileprivate func updateDictionaryPreferences(_ newPref: [AnyHashable: Any]) {
        if var gDomain = globalDomain() {
            gDomain[DictionaryServicesKey] = newPref as AnyObject?
            userDefaults().setPersistentDomain(gDomain, forName: AppleGlobalDomainName)
        }
    }
    
    // Get a list containing current active dictionaries.
    // This is stored in dictionary preferences.
    fileprivate func getActiveDictionariesList() -> [NSString]? {
        return dictionaryPreferences()?[ActiveDictionariesKey] as! [NSString]?
    }

    fileprivate func updateActiveDictionaries(_ activeDictionaries : [NSString]) {
        let newPref: [AnyHashable: Any]
        if var currentPref = dictionaryPreferences() {
            currentPref[ActiveDictionariesKey] = activeDictionaries
            newPref = currentPref
        } else {
            Swift.print("Prease set default dictionary before using...")
            return
        }

        updateDictionaryPreferences(newPref)
    }
     */
    
    func guessWord(_ text: String) -> [String]? {
        let checker = NSSpellChecker.shared()
        let range = NSRange(location: 0, length: text.characters.count)
        return checker.guesses(forWordRange: range, in: text, language: "en", inSpellDocumentWithTag: 0)
    }

    // TODO: Enable user to choose dictionary
    //       `inDictionary` parameter is reserved for future use, so pass NULL.
    func lookUp(_ word : String, inDictionary dictionaryPath : String? = nil) -> [SearchResultInfo] {
        var results: [SearchResultInfo] = []
        var words = [word]
        if let suggestions = guessWord(word) {
            words += suggestions
        }

        // Save current dictionary setting
        /*
        let currentActiveDics = getActiveDictionariesList()
         */

        // Update active dictionary to look up
        /*
        updateActiveDictionaries([dictionaryPath as NSString])
         */
        
        for w in words {
            let CFWord = w as CFString
            let range  = CFRangeMake(0, (w as NSString).length)
            if let r = DCSCopyTextDefinition(nil, CFWord, range) {
                results.append(SearchResultInfo(title: w, body: r.takeUnretainedValue() as String))
            }
        }
        

        // Restore dictionary setting
        /*
        if currentActiveDics != nil {
           updateActiveDictionaries(currentActiveDics!)
        }
         */

        return results
    }
}
