//
//  WriteWord.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 20.04.2023.
//

import SwiftUI

struct WriteWord: View {
    
    @ObservedObject var viewModel: WriteWordViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .top) {
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
                        
                        Text(viewModel.translateStatus)
                            .offset(y: 170)
                            .font(.title3)
                            .foregroundColor(.white)
                            .animation(.spring(), value: 0.5)
                    }
                    .padding()
                    
                    TextField("Write translation", text: $viewModel.translate)
                        .background(Rectangle()
                            .fill(Color.lightGrayColor)
                            .frame(width: 300, height: 35)
                            .cornerRadius(10)
                        )
                        .foregroundColor(.white)
                        .frame(width: 280)
                        .autocorrectionDisabled(true)
                    
                    
                    HStack {
                        Button {
                            viewModel.checkIndex()
                            viewModel.closeKeyboard()
                            withAnimation {
                                viewModel.skipCard()
                            }
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
                        .offset(x: -50, y: 30)
                        
                        Button {
                            if viewModel.translate == "" {
                                viewModel.translateStatus = "Please enter translation below"
                            } else {
                                viewModel.closeKeyboard()
                                viewModel.checkTranslation()
                            }
                            
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
                        .offset(x: 50, y: 30)
                    }
                }
                .padding(.bottom, viewModel.keyboardOffset - 100)
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
                    
                    Spacer()
                }
            }
        }
        .embedNavigationView(with: "WriteCards")
        
        .onAppear {
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
