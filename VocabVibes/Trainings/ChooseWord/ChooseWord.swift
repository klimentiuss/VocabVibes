//
//  ChooseWord.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 20.04.2023.
//

import SwiftUI

struct ChooseWord: View {
    
    @ObservedObject var viewModel: ChooseWordViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .top) {
            BackgroundView()
            
            switch viewModel.status {
            case .readyToDisplay:
                VStack {
                    //MARK: - Displaying cards
                    ZStack {
                        ForEach(Array(viewModel.wordsToTraining.enumerated()), id: \.1.id) { index, word in
                            CardView(viewModel: CardViewModel(word: word.wordValue))
                                .offset(x: index == viewModel.currentCardIndex ? 0 : 500)
                                .opacity(index == viewModel.currentCardIndex ? 1 : 0.5)
                        }
                        
                    }
                    .padding()
                    
                    //MARK: - Displaying buttons with words
                    AnswerButtonsView(answerButtons: $viewModel.answerButtons) { index in
                        viewModel.checkAnswer(index)
                    }
                }
            case .lastWord:
                FinishTrainingView(correctAnswersCount: viewModel.correctAnswerIndex) {
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
        .embedNavigationView(with: "ChooseOne")
        .onAppear {
            viewModel.shuffleWords()
            viewModel.generateButtons()
        }
        //MARK: - Exiting a training when the app is closed
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

//struct ChooseWord_Previews: PreviewProvider {
//    static var previews: some View {
//        @State var wordList: WordList? = WordList.example
//        ChooseWord(viewModel: ChooseWordViewModel(selectedWordList: $wordList))
//    }
//}
