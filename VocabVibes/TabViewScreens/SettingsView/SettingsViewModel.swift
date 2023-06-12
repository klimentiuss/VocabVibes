//
//  SettingsViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 07.06.2023.
//

import Foundation

class SettingsViewModel: ObservableObject {
    
    
    let trainingOptions = [3, 4, 20, 25, 30]
    
    @Published var switcher = false
    @Published var wordsPerTraining: Int = UserDefaults.standard.integer(forKey: "wordsPerTraining") {
        didSet {
            UserDefaults.standard.set(wordsPerTraining, forKey: "wordsPerTraining")
        }
    }
    

    
}
