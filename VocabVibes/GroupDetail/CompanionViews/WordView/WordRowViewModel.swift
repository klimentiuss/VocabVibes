//
//  WordRowViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 17.04.2023.
//

import SwiftUI

class WordRowViewModel: ObservableObject {
    
    let word: Word
    
    func getRatingColors(with rating: Int) -> [Color] {
        var colors: [Color] = []
        
        switch rating {
        case 0...2: colors = [.ratingRed]
        case 3: colors = [.ratingRed, .ratingYellow]
        case 4: colors = [.ratingRed, .ratingYellow, .ratingYellow]
        case 5: colors = [.ratingRed, .ratingYellow, .ratingYellow, .ratingYellow, .ratingGreen]
        case 6: colors = [.ratingYellow, .ratingYellow, .ratingYellow, .ratingGreen]
        case 7: colors = [.ratingYellow, .ratingYellow, .ratingGreen]
        case 8: colors = [.ratingYellow, .ratingGreen]
        case 9...10: colors = [.ratingGreen]
        default: break
        }
        
        return colors
    }
    
    init(word: Word) {
        self.word = word
    }
    
}
