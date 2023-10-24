//
//  AllWordView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 20.04.2023.
//

import SwiftUI
import RealmSwift

struct AllWordsView: View {
    
    @ObservedObject var viewModel = AllWordsViewModel()
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack(alignment: .leading) {
                List {
                    ForEach(viewModel.search(by: viewModel.searchWord, in: viewModel.words.freeze()), id: \.id) { word in
                        WordRow(
                            viewModel: WordRowViewModel(word: word),
                            height: word.wordValue.count > 30 ? 85 : 60)
                            .listRowBackground(Color.coalBlack)
                            .swipeActions {
                                Button(role: .destructive) {
                                    StorageManager.shared.deleteWord(word: word)
                                    
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(Color.red)
                                
                            }
                    }

                }
                .searchable(text: $viewModel.searchWord)
                .listStyle(.plain)
            }
        }
        .onAppear {
            viewModel.updateView()
        }
        .embedNavigationView(with: "keyAllWords".localized)
    }
}

struct AllWordView_Previews: PreviewProvider {
    static var previews: some View {
        AllWordsView()
    }
}
