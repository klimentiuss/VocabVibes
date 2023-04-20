//
//  WriteWord.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 20.04.2023.
//

import SwiftUI

struct WriteCard: View {
    
    @ObservedObject var viewModel: WriteCardViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.lightGrayColor)
                .frame(width: 320, height: 420)
                .cornerRadius(20)
            
            VStack {
                Text(viewModel.word)
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
   
    }
}

struct WriteCard_Previews: PreviewProvider {
    static var previews: some View {
        WriteCard(viewModel: WriteCardViewModel(word: "Hi"))
    }
}
