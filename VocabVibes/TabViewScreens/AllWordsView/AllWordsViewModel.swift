//
//  AllWordsViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 17.05.2023.
//

import Foundation
import RealmSwift

class AllWordsViewModel: ObservableObject {
    @ObservedResults(Word.self) var words
    @ObservedResults(WordList.self) var groups
    
    @Published var searchWord = ""
    @Published var sortingMethod: WordSorting = .unsorted
    
    func updateView() {
        objectWillChange.send()
    }
        
    
}

extension AllWordsViewModel: ListSortable {
    
}
