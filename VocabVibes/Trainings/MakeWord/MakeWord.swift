//
//  MakeWord.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 20.04.2023.
//

import SwiftUI

struct MakeWord: View {
    
    @ObservedObject var viewModel: MakeWordViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            switch viewModel.status {
            case .readyToDisplay:
                VStack {
                    //MARK: - Displaying cards
                    ZStack {
                        ForEach(Array(viewModel.wordsToTraining.enumerated()), id: \.1.id) { index, word in
                            CardView(viewModel: CardViewModel(word: word.wordValue))
                            //Movement and disappearance cards
                                .offset(x: index == viewModel.currentCardIndex ? 0 : 500)
                                .opacity(index == viewModel.currentCardIndex ? 1 : 0.1)
                        }
                        
                        Text(viewModel.translateStatus)
                            .offset(y: 170)
                            .font(.title3)
                            .foregroundColor(.white)
                            .animation(.spring(), value: 0.5)
                    }
                    
                    //MARK: - Composing a word
                    
                    ComposingWordView(answer: $viewModel.answer) {
                        viewModel.returnCharacter()
                    }

                    //MARK: - Splitting a word into letters
                    
                    SplittingWordView(arrayCharacter: viewModel.arrayCharacter) { char in
                        viewModel.addCharacter(char: char)
                    }
                    
                    //MARK: - Skip and Check Buttons
                    HStack {
                        CustomButtonView(
                            buttonIcon: "rectangle.portrait.and.arrow.right",
                            size: 40,
                            color: .ratingRed)
                        {
                            viewModel.skipCard()
                            viewModel.changeCard()
                        }
                        .offset(x: -50, y: 20)
                        
                        CustomButtonView(
                            buttonIcon: "checkmark",
                            size: 30,
                            color: .ratingEmerald)
                        {
                            viewModel.checkAnswer()
                        }
                        .offset(x: 50, y: 20)
                    }
                }
            case .lastWord:
                FinishTrainingView(correctAnswersCount: viewModel.correctAnswersCount) {
                    self.presentationMode.wrappedValue.dismiss()
                }
            case .fewWords:
                WarningView() {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .embedNavigationView(with: "MakeWord")
        .onAppear{
            viewModel.shuffleWords()
            viewModel.brokeWord()
        }
        //MARK: - Exiting a training when the app is closed
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct MakeWord_Previews: PreviewProvider {
    static var previews: some View {
        @State var wordList: WordList? = WordList.example
        MakeWord(viewModel: MakeWordViewModel(selectedWordList: $wordList))
    }
}
