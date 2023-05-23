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
            
            if !viewModel.isLast {
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
                    HStack {
                        TextField("", text: $viewModel.answer)
                            .background(Rectangle()
                                .fill(Color.lightGrayColor)
                                .frame(width: 250, height: 42)
                                .cornerRadius(10)
                                        
                            )
                            .foregroundColor(.white)
                            .frame(width: 220)
                            .padding()
                        
                        Button {
                            if !viewModel.answer.isEmpty {
                                let lastChar = viewModel.answer.removeLast()
                                viewModel.arrayCharacter.append(lastChar)
                            }
                        } label: {
                            Image(systemName: "delete.left")
                                .foregroundColor(.white)
                                .font(.title)
                        }
                        .buttonStyle(.bordered)
                        .foregroundColor(.white)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.arrayCharacter, id: \.self) { char in
                                Button {
                                    viewModel.addCharacter(char: char)
                                } label: {
                                    Text(String(char))
                                }
                                .buttonStyle(.bordered)
                                .foregroundColor(.white)
                                .font(.title)
                            }
                        }
                        
                    }
                    .frame(width: 280)
                    
                    
                    
                    HStack {
                        Button {
                            viewModel.skipCard()
                            viewModel.changeCard()
                        } label: {
                            Rectangle()
                                .frame(width: 80, height: 80)
                                .cornerRadius(20)
                                .foregroundColor(Color.lightGrayColor)
                                .overlay {
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .resizable()
                                        .foregroundColor(.red)
                                        .frame(width: 40, height: 40)
                                }
                        }
                        .offset(x: -50, y: 20)
                        
                        Button {
                            viewModel.checkAnswer()
                        } label: {
                            Rectangle()
                                .frame(width: 80, height: 80)
                                .cornerRadius(20)
                                .foregroundColor(Color.lightGrayColor)
                                .overlay {
                                    Image(systemName: "checkmark")
                                        .resizable()
                                        .foregroundColor(.green)
                                        .frame(width: 30, height: 30)
                                }
                        }
                        .offset(x: 50, y: 20)
                    }
                }
            } else {
                VStack(alignment: .center) {
                    Spacer()
                    Text("Correct Answers: \(viewModel.correctAnswersCount)")
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
        .embedNavigationView(with: "MakeWord")
        .onAppear{
            viewModel.brokeWord()
        }
    }
}

//struct MakeWord_Previews: PreviewProvider {
//    static var previews: some View {
//        MakeWord()
//    }
//}
