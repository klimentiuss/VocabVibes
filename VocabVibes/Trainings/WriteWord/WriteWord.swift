//
//  WriteWord.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 20.04.2023.
//

import SwiftUI

struct WriteWord: View {
    
    @StateObject var viewModel: WriteWordViewModel
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
                            CardView(viewModel: CardViewModel(word: word))
                                .offset(x: index == viewModel.currentCardIndex ? 0 : 500)
                                .opacity(index == viewModel.currentCardIndex ? 1 : 0.5)
                        }
                        
                        Text(viewModel.translateStatus)
                            .offset(y: screenSize().height >= 780 ? 140 : 100)
                            .font(.title3)
                            .foregroundColor(.white)
                            .animation(.spring(), value: 0.5)
                    }
                    
                    .padding()
                    //MARK: - Writing word
                    TextField("keyWriteTranslation".localized, text: $viewModel.translate)
                        .background(Rectangle()
                            .fill(Color.lightCoalBlack)
                            .frame(width: 300, height: 35)
                            .cornerRadius(10)
                        )
                        .foregroundColor(.white)
                        .frame(width: 280)
                        .autocorrectionDisabled(true)
                    
                    //MARK: - Skip and answer buttons
                    HStack {
                        CustomButtonView(
                            buttonIcon: "rectangle.portrait.and.arrow.right",
                            size: 40,
                            color: .ratingRed)
                        {
                            viewModel.checkIndex()
                            viewModel.closeKeyboard()
                            viewModel.skipCard()
                        }
                        .offset(x: -50, y: 30)
                        
                        CustomButtonView(
                            buttonIcon: "checkmark",
                            size: 30,
                            color: .ratingEmerald)
                        {
                            viewModel.checkTranslation()
                        }
                        .offset(x: 50, y: 30)
                    }
                }
                .padding(.bottom, viewModel.keyboardOffset - 100)
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
        .embedNavigationView(with: "keyWriteCards".localized)
        
        .onAppear {
            viewModel.shuffleWords()
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? CGRect.zero
                viewModel.keyboardOffset = keyboardFrame.height
            }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                viewModel.keyboardOffset = 0
            }
        }
    }
}

//struct WriteWord_Previews: PreviewProvider {
//    static var previews: some View {
//        WriteWord()
//    }
//}
