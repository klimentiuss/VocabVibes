//
//  GroupDetailSecondViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 07.05.2023.
//

import SwiftUI
import RealmSwift

class GroupDetailViewModel: ObservableObject {
    
    
    @ObservedRealmObject var group: WordList
    @ObservedResults(WordList.self) var wordList
    
    @Published var addNewWordIsPressed = false
    
    @Published var word = ""
    @Published var transalte = ""
    @Published var selectedWordList: WordList
    @Published var warningText = ""
    
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
    // тут 2 метода одинаковые +-, придумать как упростить
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
    
    func delete(at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let selectedListRef = ThreadSafeReference(to: selectedWordList)
        
        do {
            let selectedList = realm.resolve(selectedListRef)
            guard let wordToDelete = selectedList?.words[index] else { return }
            
            try realm.write {
                selectedList?.words.remove(at: index)
                realm.delete(wordToDelete)
            }
        } catch {
            print("Error deleting word: \(error.localizedDescription)")
        }
    }
    
    func getSelectedWordList() {
        selectedWordList = group
        addNewWordIsPressed.toggle()
    }
    
    init(group: WordList, addNewWordIsPressed: Bool = false, word: String = "", transalte: String = "", selectedWordList: WordList, warningText: String = "") {
        self.group = group
        self.addNewWordIsPressed = addNewWordIsPressed
        self.word = word
        self.transalte = transalte
        self.selectedWordList = selectedWordList
        self.warningText = warningText
    }

}

