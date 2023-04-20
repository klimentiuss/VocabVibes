//
//  FlashCardView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 19.04.2023.
//

import SwiftUI

struct FlashCardView: View {
    @StateObject var viewModel: FlashCardViewModel
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            if let words = viewModel.selectedWordList?.words {
                ForEach(words.shuffled(), id: \.id) { word in
                    //CardView(word: word.wordValue, translated: word.wordTranslation, counter: viewModel.counter, currentCardIndex: viewModel.currentCardIndex)
                    CardView(viewModel: CardViewModel(word: word.wordValue, translated: word.wordTranslation))
                }
            }
        }
        .embedNavigationView(with: "FlashCards")
    }
}


//struct FlashCardView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        FlashCardView(viewModel: FlashCardViewModel(selectedWordList: ))
//    }
//}
