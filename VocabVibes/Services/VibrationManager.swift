//
//  VibrationManager.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 10.06.2023.
//

import SwiftUI
//import CoreHaptics


class VibrationManager {
    static let shared = VibrationManager()
    
   // @Published var engine: CHHapticEngine?

    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func simpleError() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    private init(){}
}


//func prepareHaptics() {
//    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
//    print("prepared")
//    do {
//        engine = try CHHapticEngine()
//        try engine?.start()
//    } catch {
//        print("error \(error.localizedDescription)")
//    }
//}
//
//func makeVibration() {
//    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
//
//    var events = [CHHapticEvent]()
//
//    for i in stride(from: 0, to: 1, by: 0.1) {
//
//        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
//        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
//        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
//        events.append(event)
//    }
//
//
//    do {
//        let pattern = try CHHapticPattern(events: events, parameters: [])
//        let player = try engine?.makePlayer(with: pattern)
//        try player?.start(atTime: 0)
//    } catch {
//        print("error pattern \(error.localizedDescription)")
//    }
//}
