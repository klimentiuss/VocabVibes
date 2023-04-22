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
                        .tint(Color.black)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                    TextField("Translate", text: $viewModel.transalte)
                        .tint(Color.black)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                    
                }
                .padding()
                Text(viewModel.warningText)
                Spacer()
                
                VStack {
                    Button {
                        viewModel.checkTextFieldsAndSave()
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
                
                
            }
        }
        .preferredColorScheme(.light)
        .navigationTitle("Add new word")
        .embedNavigationView(with: "Add new word")
    }
}

struct NewWordSreen_Previews: PreviewProvider {
    static var previews: some View {
        NewWordSreen(viewModel: NewWordSreenViewModel(selectedWordList: WordList.example))
    }
}
