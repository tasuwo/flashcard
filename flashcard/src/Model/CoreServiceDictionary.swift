//
//  Dictionary.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/09.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa
import WebKit
import Foundation

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
    func lookUp(_ word: String, inDictionary _: String? = nil) -> [SearchResultInfo] {
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
            let range = CFRangeMake(0, (w as NSString).length)
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

    static func parseToHTML(_ result: String) -> String {
        var body = ""

        let tmp1 = result.componentsSeparatedByAfterStringAt("/", num: 2)
        let tmp2 = tmp1[0].componentsSeparatedByBeforeStringAt("/", num: 1)
        let word = tmp2[0]
        let pronunce = tmp2.count >= 2 ? tmp2[1] : ""
        var definision = tmp1.count >= 2 ? tmp1[1] : ""
        var etymology = ""

        let tmp3 = definision.componentsSeparatedByAfterStringAt("〗", num: 1)
        if tmp3.count > 1 {
            etymology = tmp3[0] + "<br>"
            definision = tmp3[1]
        }

        // ▸ で改行
        let bulletPoints = definision.componentsSeparatedByBeforeString("▸")
        var definisionArray: [String] = [bulletPoints[0] + "<br>"]
        var isFirstLine = true
        for bulletPoint in bulletPoints {
            if isFirstLine {
                isFirstLine = false
                continue
            }
            // TODO: 最初にマッチしたもののみ置換する
            /* let pattern = "([a-zA-Z0-9\\s\\[\\].〜]+)"
             let replace = "$1<br>"
             definisionArray.append(bulletPoint.stringByReplacingOccurrencesOfString(
             pattern,
             withString: replace,
             options: NSStringCompareOptions.RegularExpressionSearch,
             range: nil)) */
            definisionArray.append(bulletPoint)
            definisionArray.append("<br>")
        }
        definision = definisionArray.joined(separator: "")

        // 段落
        let pattern = "([0-9]+\\s)"
        let replace = "</div><div id='paragraph'>$1"
        definision = definision.replacingOccurrences(
            of: pattern,
            with: replace,
            options: NSString.CompareOptions.regularExpression,
            range: nil)
        definision = definision + "</p>"

        body = "<span id='word'>" + word.removeInt() + "</span>"
            + "<span id='pronunce'>" + pronunce + "</span>"
            + "<br>"
            + etymology
            + definision

        var css: [String] = []
        css.append("body {font-size:12px;font-family:sans-serif;}")
        css.append("#word {font-size:14px;font-weight:bold;}")
        css.append("#pronunce {font-size:10px;color:#6E6E6E;}")
        css.append("#paragraph {text-indent:-10px;margin-left:10px;}")

        let html = "<html>"
            + "<head>"
            + "<style type=\"text/css\">"
            + css.joined(separator: "")
            + "</style>"
            + "</head>"
            + "<body>"
            + body
            + "</body>"
            + "</html>"

        return html
    }
}
