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
            if !viewModel.isLast && viewModel.selectedWordList?.words.count ?? 0 >= 3 {
                VStack {
                    ZStack {
                        if let list = viewModel.selectedWordList?.words {
                            ForEach(Array(list.enumerated()), id: \.1.id) { index, word in
                                CardView(viewModel: CardViewModel(word: word.wordValue))
                                    .offset(x: index == viewModel.currentCardIndex ? 0 : 500)
                                    .opacity(index == viewModel.currentCardIndex ? 1 : 0.5)
                            }
                        }
                    }
                    .padding()
                    
                    VStack {
                        ForEach($viewModel.answerButtons.indices, id: \.self) { index in
                            Button {
                                viewModel.checkAnswer(index)
                            } label: {
                                Text(viewModel.answerButtons[index])
                                    .frame(width: 280, height: 25)
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                }
            } else {
                
                VStack(alignment: .center) {
                    Spacer()
                    viewModel.selectedWordList?.words.count ?? 0 >= 3
                    ?
                    Text("Correct Answers: \(viewModel.correctAnswersCount)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                    :
                    Text("Few words in the group.\nPlease add new words.")
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                    
                    VStack(alignment: .center) {
                        Button("Go back") {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        .foregroundColor(.tealColor)
                        .buttonStyle(.bordered)
                        .padding()
                    }
                    Spacer()
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
        .navigationTitle("ChooseCards")
        .embedNavigationView(with: "ChooseOne")
        .onAppear {
            if viewModel.selectedWordList?.words.count ?? 0 >= 3 {
                self.viewModel.generateButtons()
            }
        }
    }
}

//struct ChooseWord_Previews: PreviewProvider {
//    static var previews: some View {
//        ChooseWord()
//    }
//}
