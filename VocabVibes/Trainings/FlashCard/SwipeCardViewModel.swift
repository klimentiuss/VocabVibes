//
//  CardViewViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 19.04.2023.
//

import SwiftUI


class SwipeCardViewModel: ObservableObject {
        
    @Published var word: Word

    @Published var color: Color = Color.lightGrayColor
    @Published var isTranslated = false
    @Published var offset = CGSize.zero
    @Published var rotation = 0.0
    @Published var isSwiped = false
    
    func swipeCard(width: CGFloat) {
        
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
            isSwiped.toggle()
            StorageManager.shared.updateWeight(of: word, isKnow: false)
        case 150...(500):
            offset = CGSize(width: 500, height: 0)
            isSwiped.toggle()
            StorageManager.shared.updateWeight(of: word, isKnow: true)
        default:
            offset = .zero
        }
        
        
    }
    
    
    func changeColor(width: CGFloat) {
        switch width {
        case -500...(-130):
            color = .red
        case 130...(500):
            color = .green
        default:
            color = Color.lightGrayColor
        }
    }
    
    init(word: Word) {
        self.word = word
    }
}
