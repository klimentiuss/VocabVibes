//
//  SwiftUIView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 23.05.2023.
//

import SwiftUI

struct RatingView: View {
    
    let viewModel: WordRowViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(colors: viewModel.getRatingColors(with: viewModel.word.wordWeight),
                                   startPoint: UnitPoint(x: 0, y: 0),
                                   endPoint: UnitPoint(x: 1, y: 1))
                )
                .frame(width: 40, height: 15)
                .cornerRadius(15)
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(viewModel: WordRowViewModel(word: Word.example))
    }
}
