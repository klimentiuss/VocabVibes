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
                    Button {
                        completion(char)
                    } label: {
                        Text(String(char))
                    }
                    .background(Color.black)
                    .cornerRadius(8)
                    .buttonStyle(.bordered)
                    .foregroundColor(Color.lightWhite)
                    .font(.title)
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
