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
            Training(trainingName: "keyBigFlashCards".localized, color: .thinGreen, image: "flashCards"),
            Training(trainingName: "keyBigChooseOne".localized, color: .softViolet, image: "chooseWord"),
            Training(trainingName: "keyBigMakeWord".localized, color: .softYellow, image: "makeWord"),
            Training(trainingName: "keyBigWriteWords".localized, color: .softPeach, image: "writeWord")
        ]
    }
}
