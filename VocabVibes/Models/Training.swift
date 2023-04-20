//
//  Training.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 19.04.2023.
//

import Foundation

struct Training {
    let trainingName: String
    
    static func getViews() -> [Training] {
        [
            Training(trainingName: "Flash\nCards\n🌅"),
            Training(trainingName: "Choose\nOne\n💡"),
            Training(trainingName: "Make\nWord\n🧩"),
            Training(trainingName: "Write\nword\n📝")
        ]
    }
}
