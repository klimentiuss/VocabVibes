//
//  WordRow.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 17.04.2023.
//

import SwiftUI

struct WordRow: View {
    
    let viewModel: WordRowViewModel

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.lightCoalBlack)
                .frame(height: 55)
                .cornerRadius(15)
            HStack {
                Text(viewModel.word.wordValue)
                    .foregroundColor(.white)
                    .font(.title2)
                
                Text(" – ")
                    .foregroundColor(.white)
                    .font(.title2)
                
                Text(viewModel.word.wordTranslation)
                    .foregroundColor(.white)
                    .font(.title2)
                    .opacity(0.5)
                Spacer()
                
                RatingView(word: viewModel.word)
            }
            .padding()
        }
    }
}

struct WordRow_Previews: PreviewProvider {
    static var previews: some View {
        WordRow(viewModel: WordRowViewModel(word: Word.example))
            .preferredColorScheme(.dark)
    }
}
