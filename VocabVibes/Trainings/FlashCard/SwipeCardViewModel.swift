//
//  CardViewViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 19.04.2023.
//

import SwiftUI


class SwipeCardViewModel: ObservableObject {
    
    @Published var word: String
    @Published var translated: String

    @Published var counter: Int = 0
    @Published var currentCardIndex: Int = 0

    @Published var color: Color = Color.lightGrayColor
    @Published var isTranslated = false
    @Published var offset = CGSize.zero
    @Published var rotation = 0.0
    
    func swipeCard(width: CGFloat) {
        
        currentCardIndex += 1
        
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
        case 150...(500):
            counter += 1
            offset = CGSize(width: 500, height: 0)
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
    
    init(word: String, translated: String) {
        self.word = word
        self.translated = translated
    }
}
