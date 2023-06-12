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
            
            switch viewModel.status {
            case .readyToDisplay:
                //MARK: - Displaying cards
                ZStack {
                    ForEach(viewModel.wordsToTraining, id: \.id) { word in
                        SwipeCardView(viewModel: SwipeCardViewModel(word: word)) {
                            viewModel.updateIndex()
                        }
                    }
                }
            case .lastWord:
                VStack(alignment: .center) {
                    Spacer()
                    Text("keyDonePractice".localized)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                    
                    Button("keyGoback".localized) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(Color.lightGreen)
                    .buttonStyle(.bordered)
                    .padding()
                    
                    Spacer()
                }
            case .fewWords:
                WarningView {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .embedNavigationView(with: "keyFlashCards".localized)
        .onAppear {
            viewModel.shuffleWords()
        }
    }
}


//struct FlashCardView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        FlashCardView(viewModel: FlashCardViewModel(selectedWordList: ))
//    }
//}
