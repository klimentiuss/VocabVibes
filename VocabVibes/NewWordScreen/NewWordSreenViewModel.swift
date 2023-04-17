//
//  NewWordSreenViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 17.04.2023.
//

import SwiftUI
import RealmSwift

class NewWordSreenViewModel: ObservableObject {
    
    @Published var word = ""
    @Published var transalte = ""
    @Published var selectedWordList: WordList
    @Published var isMultiply = false
    
    @ObservedResults(WordList.self) var wordList
    
    let realm = try! Realm()
    
    func saveNewWord() {
        let newWord = Word()
        newWord.wordValue = word
        newWord.wordTranslation = transalte
        
        do {
            let selectedListRef = ThreadSafeReference(to: selectedWordList)
            
            try realm.write {
                guard let selectedList = realm.resolve(selectedListRef) else { return }
                selectedList.words.append(newWord)
            }
        } catch {
            print("Error adding word: \(error.localizedDescription)")
        }
        
        word = ""
        transalte = ""
    }
    
    init(selectedWordList: WordList) {
        self.selectedWordList = selectedWordList
    }
}
