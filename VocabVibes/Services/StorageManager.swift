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
    
    func updateWeight(of word: Word, isKnow: Bool ) {
            do {
                let realm = try Realm()
                try realm.write {
                    word.wordWeight += isKnow ? 1 : -1
                }
            } catch {
                print("Failed to update age: \(error)")
            }
        }
}
