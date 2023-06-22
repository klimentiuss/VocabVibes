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
            UserDefaults.standard.set(true, forKey: "vibrationToggle")
            UserDefaults.standard.set(true, forKey: "startLearning")
            UserDefaults.standard.set(10, forKey: "wordsPerTraining")
            
            let initialList = WordList()
            initialList.nameOfGroup = "keyInitialGroup".localized
            
            
            let apple = Word()
            apple.wordValue = "apple"
            apple.wordTranslation = "keyApple".localized
            
            let phone = Word()
            phone.wordValue = "phone"
            phone.wordTranslation = "keyPhone".localized
            
            let app = Word()
            app.wordValue = "app"
            app.wordTranslation = "keyApp".localized
            
            let card = Word()
            card.wordValue = "card"
            card.wordTranslation = "keyCard".localized
            
            initialList.words.append(apple)
            initialList.words.append(phone)
            initialList.words.append(app)
            initialList.words.append(card)
            $wordList.append(initialList)
        }
    }
    
    private init() {}
}
