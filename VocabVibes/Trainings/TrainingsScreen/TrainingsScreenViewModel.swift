//
//  TrainingsScreenViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 19.04.2023.
//

import SwiftUI
import RealmSwift

class TrainingsScreenViewModel: ObservableObject {
    
    
    @ObservedResults(WordList.self) var wordList
    @Published var selectedWordList: WordList?
    @Published var trainings = Training.getViews()
    
    let lagreFixedColumns: [GridItem] = [
        GridItem(.fixed(170), spacing: 15),
        GridItem(.fixed(170), spacing: 15)
    ]
    
    func getFirstlist() {
        if let firstWordList = wordList.first {
            selectedWordList = firstWordList
        }
    }
    
    init() {
        self.selectedWordList = wordList.first
    }
}

