//
//  FlashCardView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 19.04.2023.
//

import SwiftUI

struct FlashCardView: View {
    @StateObject var viewModel: FlashCardViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            //переделать на enum
            if !viewModel.isLast {
                ZStack {
                    if let words = viewModel.selectedWordList?.words {
                        ForEach(words.shuffled(), id: \.id) { word in
                            SwipeCardView(viewModel: SwipeCardViewModel(word: word)) {
                                viewModel.updateIndex()
                            }
                            
                        }
                    }
                }
            } else {
                VStack(alignment: .center) {
                    Spacer()
                    Text("You've done practive")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                    
                    Button("Go back") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.tealColor)
                    .buttonStyle(.bordered)
                    .padding()
                    
                    Spacer()
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
