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
    @Published var correctAnswerIndex = 0//
    @Published var isLast = false//
    @Published var isWrong = false
    @Published var correctAnswersCount = 0
    
    init(selectedWordList: Binding<WordList?>) {
        self._selectedWordList = selectedWordList
    }
    
    func generateButtons() {
        isWrong = false
        let correctAnswer = selectedWordList?.words[currentCardIndex].wordTranslation ?? ""
        var options = selectedWordList!.words.map{$0.wordTranslation}.shuffled()
        options.removeAll(where: { $0 == correctAnswer })
        options.shuffle()
        //баг, если в группе 1 слово
        if options.count >= 2 {
            correctAnswerIndex = Int.random(in: 0..<min(options.count, 3)) // ensure we have enough options
            answerButtons = Array(options.prefix(3)) + [correctAnswer]
            answerButtons.swapAt(correctAnswerIndex, answerButtons.count-1)
        }
        
    }
    
    func checkIndex() {
        if currentCardIndex < selectedWordList!.words.count - 1 {
            withAnimation {
                currentCardIndex += 1
            }
            generateButtons()
        } else {
            isLast.toggle()
        }
    }
    
    func checkAnswer(_ selectedButtonIndex: Int) {
        
        if isWrong {
            return
        }
        
        guard let word = selectedWordList?.words[currentCardIndex] else { return }
        
        if selectedButtonIndex == correctAnswerIndex {
            answerButtons[selectedButtonIndex] = "✅ " + answerButtons[selectedButtonIndex]
            answerButtons = answerButtons.map { $0 == word.wordTranslation ? "🟢 " + $0 : $0 }
            
            StorageManager.shared.updateWeight(of: word, isKnow: true)
            correctAnswersCount += 1
            withAnimation {
                checkIndex()
                generateButtons()
            }
            return
        } else {
            StorageManager.shared.updateWeight(of: word, isKnow: false)
        }
        
        answerButtons[selectedButtonIndex] = "❌ " + answerButtons[selectedButtonIndex]
        answerButtons[correctAnswerIndex] = "🟢 " + answerButtons[correctAnswerIndex]
        isWrong = true
    }
}
