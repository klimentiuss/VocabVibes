//
//  ChooseWordViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 20.04.2023.
//

import SwiftUI


class ChooseWordViewModel: ObservableObject {
    @Binding var selectedWordList: WordList?
    
    @Published var currentCardIndex = 0//
    @Published var answerButtons = [String]()
    @Published var correctAnswerIndex = 0
    @Published var isWrong = false
    @Published var correctAnswersCount = 0
    
    @Published var wordsToTraining = [Word]()
    @Published var status: StatusView
    @Published var prefix = UserDefaults.standard.integer(forKey: "wordsPerTraining")
    
    func shuffleWords() {
        if let words = selectedWordList?.words.shuffled() {
            wordsToTraining = words.prefix(prefix).shuffled()
        }
        status = wordsToTraining.count > 2 ? .readyToDisplay : .fewWords
    }
    
    
    func generateButtons() {
        if status == .readyToDisplay  {
            isWrong = false
            let correctAnswer = wordsToTraining[currentCardIndex].wordTranslation
            var options = wordsToTraining.map{$0.wordTranslation}.shuffled()
            options.removeAll(where: { $0 == correctAnswer })
            options.shuffle()
            correctAnswerIndex = Int.random(in: 0..<min(options.count, 3)) // ensure we have enough options
            answerButtons = Array(options.prefix(3)) + [correctAnswer]
            answerButtons.swapAt(correctAnswerIndex, answerButtons.count-1)
        }
    }
    
    func checkIndex() {
        
        if currentCardIndex >= wordsToTraining.count - 1 || currentCardIndex == prefix {
            status = .lastWord
        } else {
            withAnimation {
                currentCardIndex += 1
            }
            generateButtons()
        }
    }
    
    func checkAnswer(_ selectedButtonIndex: Int) {
        
        if isWrong {
            return
        }
                
        if selectedButtonIndex == correctAnswerIndex {
            StorageManager.shared.updateWeight(of: wordsToTraining[currentCardIndex], isKnow: true)
            answerButtons[selectedButtonIndex] = "✅ " + answerButtons[selectedButtonIndex]
            correctAnswersCount += 1
            checkIndex()
            VibrationManager.shared.simpleSuccess()
            generateButtons()
            return
        } else {
            StorageManager.shared.updateWeight(of: wordsToTraining[currentCardIndex], isKnow: false)
            answerButtons[selectedButtonIndex] = "❌ " + answerButtons[selectedButtonIndex]
            answerButtons[correctAnswerIndex] = "🟢 " + answerButtons[correctAnswerIndex]
            isWrong = true
            VibrationManager.shared.simpleError()
        }
    }
    
    init(selectedWordList: Binding<WordList?>) {
        self._selectedWordList = selectedWordList
        self.status = .readyToDisplay
    }
}
