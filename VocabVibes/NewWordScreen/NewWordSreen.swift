//
//  NewWordSreen.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 17.04.2023.
//

import SwiftUI

struct NewWordSreen: View {
    
    @ObservedObject var viewModel: NewWordSreenViewModel    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .top) {
            BackgroundView()
            VStack {
                VStack(alignment: .leading) {
                    TextField("Word", text: $viewModel.word)
                        .textFieldStyle(.roundedBorder)
                    TextField("Translate", text: $viewModel.transalte)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                Spacer()
                
                VStack {
                    Button {
                        viewModel.saveNewWord()
                    } label: {
                        Text("Save")
                    }
                    .buttonStyle(.bordered)
                    .padding()
                    Button {
                            dismiss()
                    } label: {
                        Text("Close")
                    }
                    .foregroundColor(.red)
                    .buttonStyle(.bordered)
                    .padding(.bottom)
                }
                

//                CustomButton(textButton: "Save", completion: {
//                    saveNewWord()
//                    if !isMultiply {
//                        presentationMode.wrappedValue.dismiss()
//                    }
//                    word = ""
//                    transalte = ""
//                })
            }
        }
        .navigationTitle("Add new word")
        .embedNavigationView(with: "Add new word")
    }
}

struct NewWordSreen_Previews: PreviewProvider {
    static var previews: some View {
        NewWordSreen(viewModel: NewWordSreenViewModel(selectedWordList: WordList.example))
    }
}
