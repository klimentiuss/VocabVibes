//
//  WriteWordViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 20.04.2023.
//

import Foundation

class CardViewModel: ObservableObject {
 
    @Published var word: Word
    @Published var translateIsShown = false
    
    init(word: Word) {
        self.word = word
    }
}
