//
//  SplittingWord.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 03.06.2023.
//

import SwiftUI

struct SplittingWordView: View {
    
    var arrayCharacter: [Character]
    var completion: (Character) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(arrayCharacter, id: \.self) { char in
                        Text(String(char))
                            .frame(width: 37, height: 45)
                            .background(Color.lightCoalBlack)
                            .cornerRadius(8)
                            .foregroundColor(Color.lightWhite)
                            .font(.title)
                            .onTapGesture {
                                completion(char)
                            }
                }
            }
            
        }
        .frame(width: 280)
    }
}

struct SplittingWordView_Previews: PreviewProvider {
    static var previews: some View {
        @State var arrayCharacter: [Character] = ["a", "b", "c"]
        SplittingWordView(arrayCharacter: arrayCharacter){_ in }
            .preferredColorScheme(.dark)
    }
}
