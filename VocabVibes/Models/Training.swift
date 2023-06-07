//
//  Training.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 19.04.2023.
//

import SwiftUI

struct Training {
    let trainingName: String
    let color: Color
    let image: String
    
    static func getViews() -> [Training] {
        [
            Training(trainingName: "Flash\nCards", color: .thinGreen, image: "flashCards"),
            Training(trainingName: "Choose\nOne", color: .softViolet, image: "chooseWord"),
            Training(trainingName: "Make\nWord", color: .softYellow, image: "makeWord"),
            Training(trainingName: "Write\nWord", color: .softPeach, image: "writeWord")
        ]
    }
}
