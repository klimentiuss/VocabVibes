//
//  WordRow.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 17.04.2023.
//

import SwiftUI

struct WordRow: View {
    
    let viewModel: WordRowViewModel
    var height: CGFloat

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.lightCoalBlack)
                .frame(height: height)
                .cornerRadius(15)
                .overlay {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(viewModel.word.wordValue)
                                .foregroundColor(.white)
                                .font(.title2)

                            Text(viewModel.word.wordTranslation)
                                .foregroundColor(.white)
                                .font(.title2)
                                .opacity(0.5)
                                
                        }

                        Spacer()

                        RatingView(viewModel: viewModel)
                    }
                    .padding(.horizontal, 20)
                }
            
        }
    }
}

struct WordRow_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        WordRow(viewModel: WordRowViewModel(word: Word.example), height: 80)
            .preferredColorScheme(.dark)
    }
}
