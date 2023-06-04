//
//  PickerView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 19.04.2023.
//

import SwiftUI

struct PickerView: View {
    
    @ObservedObject var viewModel: TrainingsScreenViewModel

    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Select group:")
                .font(.title3)
                .foregroundColor(.lightWhite)
                .bold()
            
            VStack(alignment: .leading) {
                Picker("Please choose a list", selection: $viewModel.selectedWordList) {
                    ForEach(viewModel.wordList, id: \.id) { list in
                        Text(list.nameOfGroup)
                            .tag(list as WordList?)
                    }
                }
                .buttonStyle(.bordered)
                
            }
        }
        .padding(.leading, 25)
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView(viewModel: TrainingsScreenViewModel(isMain: true))
    }
}
