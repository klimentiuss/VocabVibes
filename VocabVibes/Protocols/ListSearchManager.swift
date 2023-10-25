//
//  ListSearchManager.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 24.10.2023.
//

import Foundation
import RealmSwift

enum WordSorting: CaseIterable, CustomStringConvertible {
    
    case unsorted
    case alphabeticallyAscending
    case byWeightAscending
    case byWeightDescending
    
    var description: String {
           switch self {
           case .unsorted: return "○"
           case .alphabeticallyAscending: return "A-Z"
           case .byWeightAscending: return "1-10"
           case .byWeightDescending: return "10-1"
           }
       }
}

protocol ListSortable {
    func sortWords<T>(group: T, by sortingMethod: WordSorting) -> [Word]
    func search(by filterText: String, in group: [Word]) -> [Word]
}

extension ListSortable {
  
    func sortWords<T>(group: T, by sortingMethod: WordSorting) -> [Word] {
        
        let arrayForSort: [Word]
        
        switch group {
        case let list as WordList:
            arrayForSort = Array(list.words)
        case let results as Results<Word>:
            arrayForSort = Array(results)
        default:
            arrayForSort = []
        }
        
        switch sortingMethod {
        case .unsorted:
            return arrayForSort
        case .alphabeticallyAscending:
            return arrayForSort.sorted { $0.wordValue < $1.wordValue}
        case .byWeightAscending:
            return arrayForSort.sorted { $0.wordWeight < $1.wordWeight}
        case .byWeightDescending:
            return arrayForSort.sorted { $0.wordWeight > $1.wordWeight}
        }
    
    }
    
    func search(by filterText: String, in group: [Word]) -> [Word] {
        if filterText.isEmpty {
            return group
        } else {
            return group.filter {
                $0.wordValue.lowercased().contains(filterText.lowercased()) ||
                $0.wordTranslation.lowercased().contains(filterText.lowercased())
            }
        }
    }
  
}
