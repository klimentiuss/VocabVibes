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
                Text("keyAllWords".localized)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 10)
                    .padding(.leading, 20)
                    .padding(.bottom, -10)
                List {
                    ForEach(viewModel.words.freeze(), id: \.id) { word in
                        WordRow(
                            viewModel: WordRowViewModel(word: word),
                            height: word.wordValue.count > 30 ? 85 : 60)
                            .listRowBackground(Color.coalBlack)
                    }
                    .onDelete { indexSet in
                        viewModel.delete(at: indexSet)
                    }
                }
                .listStyle(.plain)

            }
                            
        }
        .onAppear {
            viewModel.updateView()
        }
        
        .navigationTitle("All words")
        .embedNavigationView(with: "All words")
    }
}

struct AllWordView_Previews: PreviewProvider {
    static var previews: some View {
        AllWordsView()
    }
}
