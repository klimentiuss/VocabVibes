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
    @Published var isMain: Bool
    
    let smallFixedColumns: [GridItem] = [
        GridItem(.fixed(100), spacing: 16),
        GridItem(.fixed(100), spacing: 16),
        GridItem(.fixed(100), spacing: 16)
    ]
    
    let flexibleColumns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
        
    ]
    
    let lagreFixedColumns: [GridItem] = [
        GridItem(.fixed(170), spacing: 20),
        GridItem(.fixed(170), spacing: 20)
    ]
    
    func getFirstlist() {
        if let firstWordList = wordList.first {
            selectedWordList = firstWordList
        }
    }
    
    init(isMain: Bool) {
        self.isMain = isMain
    }
}
