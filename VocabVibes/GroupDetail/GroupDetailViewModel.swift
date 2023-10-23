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
            
    @Published var alertPresented = false
    @Published var editingValue = ""
    @Published var editingTranslation = ""
    @Published var threadedWord: ThreadSafeReference<Word>?
    
    @Published var searchWord = ""
    @Published var isSearchShown = false
    
    @Published var offsetMove: CGFloat = -110
    
    
    func showOrHide() {
        addNewWordIsPressed.toggle()
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        offsetMove = addNewWordIsPressed ?  0 : -110
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
            warningText = "keyFillCorrect".localized
            return
        }
        
        saveNewWord(value: trimmedWord, translate: trimmedTranslate)
        VibrationManager.shared.makeVibration(with: true)
        clearFields()
        
    }
    
    func saveNewWord(value: String, translate: String) {
        let newWord = Word()
        
        newWord.wordValue = UserDefaults.standard.bool(forKey: "upperCaseSwitcher") ? value : value.lowercased()
        newWord.wordTranslation = UserDefaults.standard.bool(forKey: "upperCaseSwitcher") ? translate : translate.lowercased()
        
        StorageManager.shared.saveWord(group: group, word: newWord)
    }
    
    func threaded(word: Word){
        threadedWord = ThreadSafeReference(to: word)
    }
    
    func prepareTextFields(word: Word) {
        editingValue = word.wordValue
        editingTranslation = word.wordTranslation
    }
    
    func search(by filterText: String, in group: WordList) -> Array<Word> {
        
        if filterText.isEmpty {
            return Array(group.words)
            } else {
                return Array(group.words.filter {
                    $0.wordValue.lowercased().contains(filterText.lowercased()) ||
                    $0.wordTranslation.lowercased().contains(filterText.lowercased())
                })
            }
    }

    
    init(group: WordList, addNewWordIsPressed: Bool = false, word: String = "", transalte: String = "", warningText: String = "") {
        self.group = group
        self.addNewWordIsPressed = addNewWordIsPressed
        self.word = word
        self.translate = transalte
        self.warningText = warningText
    }

}

