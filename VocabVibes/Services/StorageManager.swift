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
    
    func deleteWord(group: WordList, index: IndexSet.Element) {
        do {
            let selectedListRef = ThreadSafeReference(to: group)
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
}
