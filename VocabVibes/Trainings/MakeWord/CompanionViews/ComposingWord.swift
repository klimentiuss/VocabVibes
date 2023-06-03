//
//  SwiftUIView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 03.06.2023.
//

import SwiftUI

struct ComposingWordView: View {
    
    @Binding var answer: String
    var completion: () -> ()
    
    var body: some View {
        HStack {
            TextField("", text: $answer)
                .background(Rectangle()
                    .fill(Color.lightGrayColor)
                    .frame(width: 250, height: 42)
                    .cornerRadius(10)
                            
                )
                .foregroundColor(.white)
                .frame(width: 220)
                .padding()
                .disabled(true)
            Button {
                completion()
            } label: {
                Image(systemName: "delete.left")
                    .foregroundColor(.white)
                    .font(.title)
            }
            .buttonStyle(.bordered)
            .foregroundColor(.white)
        }
    }
}

struct ComposingWordView_Previews: PreviewProvider {
    
    static var previews: some View {
        @State var textString = "type here"
        ComposingWordView(answer: $textString){}
    }
}
