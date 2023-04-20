//
//  FlashCardViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 19.04.2023.
//

import SwiftUI

class FlashCardViewModel: ObservableObject {
    @Binding var selectedWordList: WordList?
    
    @Published var counter = 0
    @Published var currentCardIndex = 0
    @Published var showCongratulations = false
    
    init(selectedWordList: Binding<WordList?>) {
        self._selectedWordList = selectedWordList
    }
}
