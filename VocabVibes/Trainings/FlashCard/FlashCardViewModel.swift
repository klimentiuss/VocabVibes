//
//  FlashCardViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 19.04.2023.
//

import SwiftUI
import RealmSwift


class FlashCardViewModel: BaseViewModel, ObservableObject {
    
    @Published var index = 0
    
    func updateIndex() {
        index += 1
        if index == wordsToTraining.count || index == prefix {
            status = .lastWord
        }
    }
}



