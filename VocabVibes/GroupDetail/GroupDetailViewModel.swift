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
    @Published var transalte = ""
    @Published var warningText = ""
        
    let realm = try! Realm()
    
    func showOrHide() {
        addNewWordIsPressed.toggle()
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

    }
    
    func clearFields() {
        warningText = ""
        word = ""
        transalte = ""
    }
    
    func checkTextFieldsAndSave() {
        let trimmedWord = word.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedTranslate = transalte.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedWord.isEmpty && !trimmedTranslate.isEmpty else {
            warningText = "Please fill in the fields correctly."
            return
        }
        
        saveNewWord()
        clearFields()
        
    }
    // тут 2 метода одинаковые +-, придумать как упростить
    func saveNewWord() {
        let newWord = Word()
        newWord.wordValue = word
        newWord.wordTranslation = transalte
        
        do {
            let selectedListRef = ThreadSafeReference(to: group)
            
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
        let selectedListRef = ThreadSafeReference(to: group)
        
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
    
    init(group: WordList, addNewWordIsPressed: Bool = false, word: String = "", transalte: String = "", warningText: String = "") {
        self.group = group
        self.addNewWordIsPressed = addNewWordIsPressed
        self.word = word
        self.transalte = transalte
        self.warningText = warningText
    }

}

