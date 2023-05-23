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
    var completion: () -> ()
    @FocusState var keyboardFocused: Field?
    
    
    
    var body: some View {
        
        Group {
            VStack(alignment: .leading) {
                TextField("Word", text: $viewModel.word)
                    .focused($keyboardFocused, equals: .word)
                    .tint(Color.white)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .onSubmit {
                        keyboardFocused = .translate
                    }
                    
                TextField("Translate", text: $viewModel.translate)
                    .tint(Color.white)
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
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                if viewModel.addNewWordIsPressed {
                    HStack {
                        Button("Close") {
                            withAnimation {
                                viewModel.showOrHide()
                                viewModel.clearFields()
                            }
                            
                            completion()
                        }
                        .animation(.linear, value: viewModel.addNewWordIsPressed)
                        .foregroundColor(.red)
                        Spacer()
                        Button("Save") {
                            viewModel.checkTextFieldsAndSave()
                        }
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


//struct AddNewWordsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewWordsView()
//    }
//}
