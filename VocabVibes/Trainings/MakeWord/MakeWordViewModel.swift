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
    
    func changeCard() {
        if currentCardIndex < selectedWordList!.words.count - 1 {
            answer = ""
            withAnimation {
                currentCardIndex += 1
            }
            brokeWord()
            print(currentCardIndex)
        } else {
            isLast.toggle()
        }
    }
    
    func checkAnswer() {
        if answer == selectedWordList?.words[currentCardIndex].wordTranslation.lowercased() {
            correctAnswersCount += 1
            changeCard()
        } else {
            print("Uncorrect :c")
        }
    }
    
    func brokeWord() {
        let correctAnswer = selectedWordList!.words[currentCardIndex].wordTranslation
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
