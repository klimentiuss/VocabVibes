//
//  StorageManager.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 21.05.2023.
//

import Foundation
import RealmSwift


class StorageManager {
    static let shared = StorageManager()
    
    private init() {}
    
    let realm = try! Realm()
    
    func updateWeight(of word: Word, isKnow: Bool ) {
        do {
            try realm.write {
                word.wordWeight = isKnow
                ? (word.wordWeight < 10 ? word.wordWeight + 1 : word.wordWeight)
                : (word.wordWeight > 0 ? word.wordWeight - 1 : word.wordWeight)
                
            }
        } catch {
            print("Failed to update age: \(error)")
        }
    }
    
    func saveWord(group: WordList, word: Word) {
        do {
            let selectedListRef = ThreadSafeReference(to: group)
            
            try realm.write {
                guard let selectedList = realm.resolve(selectedListRef) else { return }
                selectedList.words.append(word)
            }
        } catch {
            print("Error adding word: \(error.localizedDescription)")
        }
    }
   
    
    func deleteWord(word: Word) {
        do {
            let selectedWordRef = ThreadSafeReference(to: word)
            guard let selectedWord = realm.resolve(selectedWordRef) else { return }
            
            try realm.write {
                realm.delete(selectedWord)
            }
        } catch {
            print("Error deleting word: \(error.localizedDescription)")
        }
    }
    
    func editWord(selectedWordRefOptional: ThreadSafeReference<Word>?, value: String, translation: String) {
            do {
                guard let selectedWordRef = selectedWordRefOptional else { return }
                guard let selectedWord = realm.resolve(selectedWordRef) else { return }
                
                try realm.write {
                    selectedWord.wordTranslation = value
                    selectedWord.wordValue = translation
                }
            } catch {
                print("Error editing word: \(error.localizedDescription)")
            }
        }
}
