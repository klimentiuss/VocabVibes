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
    @Published var warningText = ""
    
    @ObservedResults(WordList.self) var wordList
    
    let realm = try! Realm()
    
    func checkTextFieldsAndSave() {
        let trimmedWord = word.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedTranslate = transalte.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedWord.isEmpty && !trimmedTranslate.isEmpty else {
            word = ""
            transalte = ""
            warningText = "Please fill in the fields correctly."
            return
        }
        
        saveNewWord()
        
        warningText = ""
        word = ""
        transalte = ""
    }
    
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
        
    }
    
    init(selectedWordList: WordList) {
        self.selectedWordList = selectedWordList
    }
}
