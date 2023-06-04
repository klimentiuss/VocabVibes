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
            Training(trainingName: "Flash\nCards", color: Color.thinGreen, image: "flashCards"),
            Training(trainingName: "Choose\nOne", color: Color(#colorLiteral(red: 0.8980392157, green: 0.8745098039, blue: 0.9411764706, alpha: 0.9)), image: "chooseWord"),
            Training(trainingName: "Make\nWord", color: Color(#colorLiteral(red: 0.9450980392, green: 0.9333333333, blue: 0.8274509804, alpha: 1)), image: "makeWord"),
            Training(trainingName: "Write\nWord", color: Color(#colorLiteral(red: 0.9333333333, green: 0.8745098039, blue: 0.8705882353, alpha: 1)), image: "writeWord")
        ]
    }
}
