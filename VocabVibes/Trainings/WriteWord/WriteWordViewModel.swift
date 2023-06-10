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
    @Published var status: StatusView
    @Published var prefix = UserDefaults.standard.integer(forKey: "wordsPerTraining")
    
    func shuffleWords() {
        if let words = selectedWordList?.words.shuffled() {
            wordsToTraining = words.prefix(prefix).shuffled()
        }
        status = wordsToTraining.count > 2 ? .readyToDisplay : .fewWords
    }
    
    func checkIndex() {
        if currentCardIndex >= wordsToTraining.count - 1 || currentCardIndex == prefix {
            status = .lastWord
        }
    }
    
    func skipCard() {
        StorageManager.shared.updateWeight(of: wordsToTraining[currentCardIndex], isKnow: false)
        currentCardIndex += 1
        translateStatus = ""
        translate = ""
    }
    
    func checkTranslation() {
        
        checkIndex()
        
        if  wordsToTraining[currentCardIndex].wordTranslation == translate.lowercased() {
            StorageManager.shared.updateWeight(of:  wordsToTraining[currentCardIndex], isKnow: true)
            correctAnswersCount += 1
            translateStatus = ""
            withAnimation {
                currentCardIndex += 1
            }
            translate = ""
            VibrationManager.shared.simpleSuccess()
            closeKeyboard()
        } else {
            VibrationManager.shared.simpleError()
            withAnimation {
                translateStatus = translate.isEmpty ? "Please enter translation below" : "Incorrect"
            }
        }
    }
    
    func closeKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
    init(selectedWordList: Binding<WordList?>) {
        self._selectedWordList = selectedWordList
        self.status = .readyToDisplay
    }
}
