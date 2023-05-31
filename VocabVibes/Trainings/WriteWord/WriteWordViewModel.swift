//
//  WriteWordViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 20.04.2023.
//

import SwiftUI


class WriteWordViewModel: ObservableObject {
    
    
    @Binding var selectedWordList: WordList?
    
    @Published var translate = ""
    @Published var currentCardIndex = 0//
    @Published var translateStatus = ""
    @Published var keyboardOffset: CGFloat = 0
    @Published var isLast = false//
    @Published var correctAnswersCount = 0//
    
    @Published var wordsToTraining = [Word]()
    
    init(selectedWordList: Binding<WordList?>) {
        self._selectedWordList = selectedWordList
    }
    
    func shuffleWords() {
        if let words = selectedWordList?.words {
            wordsToTraining = words.shuffled()
            
        }
    }
    
    func checkIndex() {
        if currentCardIndex > selectedWordList!.words.count - 2 {
            isLast.toggle()
        }
    }
    
    func skipCard() {
        translateStatus = ""
        translate = ""
        StorageManager.shared.updateWeight(of: wordsToTraining[currentCardIndex], isKnow: false)
        currentCardIndex += 1
    }
    
    func checkTranslation() {
        
        checkIndex()
        
        if  wordsToTraining[currentCardIndex].wordTranslation == translate.lowercased() {
            correctAnswersCount += 1
            StorageManager.shared.updateWeight(of:  wordsToTraining[currentCardIndex], isKnow: true)
            translateStatus = ""
            withAnimation {
                currentCardIndex += 1
            }
            self.translate = ""
        } else {
            withAnimation {
                translateStatus = "Incorrect"
            }
        }
    }
    
    func closeKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
