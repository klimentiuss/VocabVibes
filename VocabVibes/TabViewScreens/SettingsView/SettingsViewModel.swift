//
//  SettingsViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 07.06.2023.
//

import SwiftUI

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
    
    @Published var upperCaseSwitcher: Bool = UserDefaults.standard.bool(forKey: "upperCaseSwitcher") {
        didSet {
            UserDefaults.standard.set(upperCaseSwitcher, forKey: "upperCaseSwitcher")
        }
    }
    
    func openPrivacyPolicy() {
        if let url = URL(string: "https://docs.google.com/document/d/e/2PACX-1vTCMCTTWn-Zi1Pm5VODxZiTdtSApGu_FKHDdnM-A4TLO9f7vJjjBPpe9lPF6Tz7yy9ki6HwiI2YH1KX/pub") {
            UIApplication.shared.open(url)
        }
    }

}
