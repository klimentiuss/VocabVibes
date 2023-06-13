//
//  VibrationManager.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 10.06.2023.
//

import SwiftUI


class VibrationManager {
    static let shared = VibrationManager()
    

    
    func makeVibration(with status: Bool) {
        if UserDefaults.standard.bool(forKey: "vibrationToggle") {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(status ? .success : .error)
        }
        
    }
    
    private init(){}
}

