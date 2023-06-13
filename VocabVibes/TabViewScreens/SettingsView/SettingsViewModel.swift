//
//  SettingsViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 07.06.2023.
//

import Foundation

class SettingsViewModel: ObservableObject {
    
    
    let trainingOptions = [10, 15, 20, 25, 30]
    
    @Published var switcher: Bool = UserDefaults.standard.bool(forKey: "vibrationToggle") {
        didSet {
            UserDefaults.standard.set(switcher, forKey: "vibrationToggle")
            VibrationManager.shared.makeVibration(with: true)
        }
    }
    @Published var wordsPerTraining: Int = UserDefaults.standard.integer(forKey: "wordsPerTraining") {
        didSet {
            UserDefaults.standard.set(wordsPerTraining, forKey: "wordsPerTraining")
        }
    }
    

    
}
