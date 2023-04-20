//
//  WriteWordViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 20.04.2023.
//

import Foundation

class WriteCardViewModel: ObservableObject {
 
    @Published var word: String
    
    init(word: String) {
        self.word = word
    }
}
