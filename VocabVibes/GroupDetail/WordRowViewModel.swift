//
//  WordRowViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 17.04.2023.
//

import Foundation

class WordRowViewModel: ObservableObject {
    
    let word: Word
    
    init(word: Word) {
        self.word = word
    }
    
}
