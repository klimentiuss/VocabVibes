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
            Text("keySelectGroup".localized)
                .font(.title3)
                .foregroundColor(.lightWhite)
                .bold()
            HStack {
                VStack(alignment: .leading) {
                    Picker("keyChooseList".localized, selection: $viewModel.selectedWordList) {
                        ForEach(viewModel.wordList, id: \.id) { list in
                            Text(list.nameOfGroup)
                                .tag(list as WordList?)
                        }
                    }
                    .buttonStyle(.bordered)
                    
                }
               
                NavigationLink {
                    if let selectedList = viewModel.selectedWordList {
                        GroupDetail(viewModel: GroupDetailViewModel(group: selectedList), isTextFieldsShown: true)
                    }
                } label: {
                    Image(systemName: "plus")
                }


            }
            
        }
        .padding(.leading, 25)
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView(viewModel: TrainingsScreenViewModel())
    }
}
