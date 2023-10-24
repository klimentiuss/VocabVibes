//
//  ListSearchManager.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 24.10.2023.
//

import Foundation
import RealmSwift


protocol ListSearchable {
    func search(by filterText: String, in group: WordList) -> Array<Word>
}

extension ListSearchable {
  
    func search<T>(by filterText: String, in group: T) -> [Word] {
        switch group {
        case let list as WordList:
            if filterText.isEmpty {
                return Array(list.words)
            } else {
                return Array(list.words.filter {
                    $0.wordValue.lowercased().contains(filterText.lowercased()) ||
                    $0.wordTranslation.lowercased().contains(filterText.lowercased())
                })
            }
        case let results as Results<Word>:
            if filterText.isEmpty {
                return Array(results)
            } else {
                return Array(results.filter {
                    $0.wordValue.lowercased().contains(filterText.lowercased()) ||
                    $0.wordTranslation.lowercased().contains(filterText.lowercased())
                })
            }
        default:
            return []
        }
    }
  
}
