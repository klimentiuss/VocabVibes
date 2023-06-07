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
    
    @Published var addNewWordIsPressed = false
    @Published var word = ""
    @Published var translate = ""
    @Published var warningText = ""
            
    func showOrHide() {
        addNewWordIsPressed.toggle()
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

    }
    
    func clearFields() {
        warningText = ""
        word = ""
        translate = ""
    }
    
    func checkTextFieldsAndSave() {
        let trimmedWord = word.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedTranslate = translate.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedWord.isEmpty && !trimmedTranslate.isEmpty else {
            warningText = "Please fill in the fields correctly."
            return
        }
        
        saveNewWord(word: trimmedWord, translate: trimmedTranslate)
        clearFields()
        
    }
    
    func saveNewWord(word: String, translate: String) {
        let newWord = Word()
        newWord.wordValue = word.lowercased()
        newWord.wordTranslation = translate.lowercased()
        
        StorageManager.shared.saveWord(group: group, word: newWord)
    }
    
    func delete(at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        
        StorageManager.shared.deleteWord(group: group, index: index)
    }
    
    init(group: WordList, addNewWordIsPressed: Bool = false, word: String = "", transalte: String = "", warningText: String = "") {
        self.group = group
        self.addNewWordIsPressed = addNewWordIsPressed
        self.word = word
        self.translate = transalte
        self.warningText = warningText
    }

}

