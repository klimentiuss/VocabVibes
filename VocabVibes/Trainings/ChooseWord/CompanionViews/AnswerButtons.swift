//
//  SwiftUIView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 03.06.2023.
//

import SwiftUI

struct AnswerButtonsView: View {
    
    @Binding var answerButtons: [String]
    var completion: (Range<Int>.Element) -> Void
    
    var body: some View {
        VStack {
            ForEach($answerButtons.indices, id: \.self) { index in
                Button {
                    completion(index)
                } label: {
                    Text(answerButtons[index])
                        .frame(width: 280, height: 25)
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .background(Color.black)
            .cornerRadius(8)
            .buttonStyle(.bordered)
            
        }
        
    }
}

struct AnswerButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        
        @State var arra: [String] = ["a", "b", "c", "d"]
        AnswerButtonsView(answerButtons: $arra){_ in }
            .preferredColorScheme(.dark)
    }
}
