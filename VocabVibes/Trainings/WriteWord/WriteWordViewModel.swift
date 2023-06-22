//
//  WriteWordViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 20.04.2023.
//

import SwiftUI

class WriteWordViewModel: BaseViewModel, ObservableObject {
    
    @Published var translate = ""
    @Published var translateStatus = ""
    @Published var keyboardOffset: CGFloat = 0
    
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
        
        if  wordsToTraining[currentCardIndex].wordTranslation == translate.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) {
            StorageManager.shared.updateWeight(of:  wordsToTraining[currentCardIndex], isKnow: true)
            correctAnswersCount += 1
            translateStatus = ""
            withAnimation {
                currentCardIndex += 1
            }
            translate = ""
            VibrationManager.shared.makeVibration(with: true)
            closeKeyboard()
        } else {
            VibrationManager.shared.makeVibration(with: false)
            withAnimation {
                translateStatus = translate.isEmpty ? "keyWriteWordWorning".localized : "keyIncorrect".localized
            }
        }
    }
    
    func closeKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
    
}
