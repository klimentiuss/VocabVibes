//
//  ChooseWord.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 20.04.2023.
//

import SwiftUI

struct ChooseWord: View {
    
    @StateObject var viewModel: ChooseWordViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .top) {
            BackgroundView()
            
            switch viewModel.status {
            case .readyToDisplay:
                VStack {
                    Spacer()
                    //MARK: - Displaying cards
                    ZStack {
                        ForEach(Array(viewModel.wordsToTraining.enumerated()), id: \.1.id) { index, word in
                            CardView(viewModel: CardViewModel(word: word))
                                .offset(x: index == viewModel.currentCardIndex ? 0 : 500)
                                .opacity(index == viewModel.currentCardIndex ? 1 : 0.5)
                        }
                        
                    }
                    .padding()
                    
                    //MARK: - Displaying buttons with words
                    AnswerButtonsView(answerButtons: $viewModel.answerButtons) { index in
                        viewModel.checkAnswer(index)
                    }
                    Spacer()
                }
            case .lastWord:
                FinishTrainingView(correctAnswersCount: viewModel.correctAnswersCount) {
                    self.presentationMode.wrappedValue.dismiss()
                }
            case .fewWords:
                WarningView {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .gesture(
            TapGesture()
                .onEnded { _ in
                    if viewModel.isWrong {
                        self.viewModel.checkIndex()
                        self.viewModel.generateButtons()
                    }
                }
        )
        .embedNavigationView(with: "keyChooseOne".localized)
        .onAppear {
            viewModel.shuffleWords()
            viewModel.generateButtons()
        }
    }
}

//struct ChooseWord_Previews: PreviewProvider {
//    static var previews: some View {
//        @State var wordList: WordList? = WordList.example
//        ChooseWord(viewModel: ChooseWordViewModel(selectedWordList: $wordList))
//    }
//}
