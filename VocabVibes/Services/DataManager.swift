//
//  DataManager.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 21.04.2023.
//

import Foundation
import RealmSwift

class DataManager {
    
    static let shared = DataManager()
    
    @ObservedResults(WordList.self) var wordList
    
    func createInitialList() {
        if !UserDefaults.standard.bool(forKey: "done") {
            UserDefaults.standard.set(true, forKey: "done")
            
            let initialList = WordList()
            initialList.nameOfGroup = "Words to learn"
            
            
            let word = Word()
            word.wordValue = "apple"
            word.wordTranslation = "яблоко"
            
            initialList.words.append(word)
            $wordList.append(initialList)
        }
    }
    
    private init() {}
}
