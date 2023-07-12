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
    
    func updateView() {
        objectWillChange.send()
    }
  
    func delete(at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }        
//        StorageManager.shared.deleteWordFromAllWords(word: words[index], index: index)
        StorageManager.shared.deleteWord(word: words[index])
    }
}
