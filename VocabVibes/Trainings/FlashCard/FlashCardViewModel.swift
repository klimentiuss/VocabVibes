//
//  FlashCardViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 19.04.2023.
//

import SwiftUI

class FlashCardViewModel: ObservableObject {
        
    @Binding var selectedWordList: WordList?
    
    @Published var index = 0
    @Published var isLast = false
    
    func updateIndex() {
        index += 1        
        if index == (selectedWordList?.words.count ?? 0) {
            isLast.toggle()
        }
    }
    
    init(selectedWordList: Binding<WordList?>) {
        self._selectedWordList = selectedWordList
    }
}
