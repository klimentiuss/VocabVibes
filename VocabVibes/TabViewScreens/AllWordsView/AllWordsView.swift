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
                Text("All words")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 10)
                    .padding(.leading, 20)
                    .padding(.bottom, -10)
                List {
                    ForEach(viewModel.words.freeze(), id: \.id) { word in
                        WordRow(viewModel: WordRowViewModel(word: word))
                            .listRowBackground(Color.darkGrayColor)
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
