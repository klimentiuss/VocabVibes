//
//  FlashCardViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 19.04.2023.
//

import SwiftUI
import RealmSwift


class FlashCardViewModel: ObservableObject {
    
    @Binding var selectedWordList: WordList?
    
    @Published var index = 0
    @Published var wordsToTraining = [Word]()
    @Published var prefix = UserDefaults.standard.integer(forKey: "wordsPerTraining")
    @Published var status: StatusView
    
    func updateIndex() {
        index += 1
        if index == wordsToTraining.count || index == prefix {
            status = .lastWord
        }
    }
    
    func shuffleWords() {
        if let words = selectedWordList?.words.shuffled() {
            wordsToTraining = words.prefix(prefix).shuffled()
        }
        status = wordsToTraining.count > 2 ? .readyToDisplay : .fewWords
    }
    
    init(selectedWordList: Binding<WordList?>) {
        self._selectedWordList = selectedWordList
        self.status = .readyToDisplay
    }
}



