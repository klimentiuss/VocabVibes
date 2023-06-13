//
//  AddNewWordsView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 12.05.2023.
//



import SwiftUI

enum Field {
    case word, translate
}

struct AddNewWordsView: View {
    
    @ObservedObject var viewModel: GroupDetailViewModel
    @FocusState var keyboardFocused: Field?
    var completion: () -> ()
    
    
    var body: some View {
        
        Group {
            VStack(alignment: .leading) {
                TextField("keyWord".localized, text: $viewModel.word)
                    .focused($keyboardFocused, equals: .word)
                    .tint(Color.lightWhite)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .onSubmit {
                        keyboardFocused = .translate
                    }
                    
                TextField("keyTranslate".localized, text: $viewModel.translate)
                    .tint(Color.lightWhite)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .submitLabel(.done)
                    .focused($keyboardFocused, equals: .translate)
                    .onSubmit {
                        keyboardFocused = .word
                        viewModel.checkTextFieldsAndSave()
                    }
                Text(viewModel.warningText)
            }
            .padding()
        }
        //MARK: - Keyboard toolbar buttons 
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                if viewModel.addNewWordIsPressed {
                    HStack {
                        Button("keyClose".localized) {
                            withAnimation {
                                viewModel.showOrHide()
                                viewModel.clearFields()
                            }
                            
                            completion()
                        }
                        .animation(.linear, value: viewModel.addNewWordIsPressed)
                        .foregroundColor(Color.ratingRed)
                        Spacer()
                        Button("keySave".localized) {
                            viewModel.checkTextFieldsAndSave()
                        }
                        .foregroundColor(Color.ratingEmerald)
                    }
                    .onAppear {
                        DispatchQueue.main.async {
                            keyboardFocused = .word
                        }
                    }
                }
            }
        }
    }
    
}


struct AddNewWordsView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewWordsView(viewModel: GroupDetailViewModel(group: WordList.example)){}
    }
}
