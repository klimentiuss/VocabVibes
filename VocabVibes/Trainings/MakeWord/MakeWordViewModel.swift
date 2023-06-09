//
//  MakeWordViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 20.04.2023.
//

import SwiftUI

class MakeWordViewModel: BaseViewModel, ObservableObject {
    
    
    @Published var arrayCharacter: [Character] = []
    @Published var answer = ""
    @Published var translateStatus = ""
    
    func returnCharacter() {
        if !answer.isEmpty {
            let lastChar = answer.removeLast()
            arrayCharacter.append(lastChar)
        }
    }
    
    func changeCard() {
        if currentCardIndex >= wordsToTraining.count - 1 || currentCardIndex == prefix {
            status = .lastWord
        } else {
            answer = ""
            translateStatus = ""
            withAnimation {
                currentCardIndex += 1
            }
            brokeWord()
        }
    }
    
    func skipCard() {
        StorageManager.shared.updateWeight(of: wordsToTraining[currentCardIndex], isKnow: false)
    }
    
    func checkAnswer() {
        if answer == wordsToTraining[currentCardIndex].wordTranslation.lowercased() {
            StorageManager.shared.updateWeight(of: wordsToTraining[currentCardIndex], isKnow: true)
            correctAnswersCount += 1
            VibrationManager.shared.makeVibration(with: true)
            changeCard()
        } else {
            VibrationManager.shared.makeVibration(with: false)
            withAnimation {
                translateStatus = answer == "" ? "keyMakeWordWarning".localized : "keyIncorrect".localized
            }
        }
    }
    
    func brokeWord() {
        if wordsToTraining.count >= 3 {
            let correctAnswer = wordsToTraining[currentCardIndex].wordTranslation
            arrayCharacter = Array(correctAnswer.lowercased()).shuffled()
        } else {
            status = .fewWords
        }
    }
    
    func addCharacter(char: Character) {
        answer += String(char)
        arrayCharacter.remove(at: arrayCharacter.firstIndex(of: char) ?? 0)
    }
}
