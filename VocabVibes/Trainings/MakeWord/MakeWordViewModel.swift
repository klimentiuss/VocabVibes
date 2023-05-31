//
//  MakeWordViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 20.04.2023.
//

import SwiftUI

class MakeWordViewModel: ObservableObject {
    @Binding var selectedWordList: WordList?
    
    @Published var arrayCharacter: [Character] = []
    @Published var answer = ""
    @Published var currentCardIndex = 0
    @Published var isLast = false
    @Published var correctAnswersCount = 0
    
    @Published var wordsToTraining = [Word]()
    
    func shuffleWords() {
        if let words = selectedWordList?.words {
            wordsToTraining = words.shuffled()
            
        }
    }
    
    
//переделать нормально, изменить на wordsToTraining[currentCardIndex]
    func changeCard() {
        if currentCardIndex < selectedWordList!.words.count - 1 {
            answer = ""
            withAnimation {
                currentCardIndex += 1
            }
            brokeWord()
        } else {
            isLast.toggle()
        }
    }
    
    func skipCard() {
       // guard let word = selectedWordList?.words[currentCardIndex] else { return }
        StorageManager.shared.updateWeight(of: wordsToTraining[currentCardIndex], isKnow: false)
    }
    
    func checkAnswer() {
       // guard let word = selectedWordList?.words[currentCardIndex] else { return }
        
        if answer == wordsToTraining[currentCardIndex].wordTranslation.lowercased() {
            StorageManager.shared.updateWeight(of: wordsToTraining[currentCardIndex], isKnow: true)
            correctAnswersCount += 1
            changeCard()
        } else {
            print("Uncorrect :c")
        }
    }
    
    func brokeWord() {
        let correctAnswer = wordsToTraining[currentCardIndex].wordTranslation
        arrayCharacter = Array(correctAnswer.lowercased()).shuffled()
    }
    
    func addCharacter(char: Character) {
        answer += String(char)
        arrayCharacter.remove(at: arrayCharacter.firstIndex(of: char) ?? 0)
    }
    
    init(selectedWordList: Binding<WordList?>) {
        self._selectedWordList = selectedWordList
    }
}
