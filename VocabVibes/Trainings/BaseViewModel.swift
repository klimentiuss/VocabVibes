//
//  BaseViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 13.06.2023.
//

import SwiftUI

enum StatusView {
    case readyToDisplay
    case lastWord
    case fewWords
}

class BaseViewModel {
    @Binding var selectedWordList: WordList? 
    
    @Published var currentCardIndex = 0
    @Published var correctAnswersCount = 0
    @Published var wordsToTraining = [Word]()
    @Published var status: StatusView
    @Published var prefix = UserDefaults.standard.integer(forKey: "wordsPerTraining")//
    
    init(selectedWordList: Binding<WordList?>) {
        self._selectedWordList = selectedWordList
        self.status = .readyToDisplay
        
    }
    
    func shuffleWords() {
        if let words = selectedWordList?.words.shuffled() {
            wordsToTraining = words.prefix(prefix).shuffled()
        }
        status = wordsToTraining.count > 2 ? .readyToDisplay : .fewWords
    }
}
