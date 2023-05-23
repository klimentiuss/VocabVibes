//
//  SwiftUIView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 23.05.2023.
//

import SwiftUI

struct RatingView: View {
    
    let word: Word
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(colors: getRatingColors(with: word.wordWeight),
                                   startPoint: UnitPoint(x: 0, y: 0),
                                   endPoint: UnitPoint(x: 1, y: 1))
                )
                .frame(width: 40, height: 15)
                .cornerRadius(15)
                
                
                
        }
        
    }
    
    func getRatingColors(with rating: Int) -> [Color] {
        var colors: [Color] = []
        
        switch rating {
        case 0...2: colors = [.ratingRed]
        case 3: colors = [.ratingRed, .ratingYellow]
        case 4: colors = [.ratingRed, .ratingYellow, .ratingYellow]
        case 5: colors = [.ratingRed, .ratingYellow, .ratingYellow, .ratingYellow, .ratingGreen]
        case 6: colors = [.ratingYellow, .ratingYellow, .ratingYellow, .ratingGreen]
        case 7: colors = [.ratingYellow, .ratingYellow, .ratingGreen]
        case 8: colors = [.ratingYellow, .ratingGreen]
        case 9...10: colors = [.ratingGreen]
        default: break
        }
        
        return colors
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(word: Word.example)
    }
}
