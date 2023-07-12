//
//  WriteWord.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 20.04.2023.
//

import SwiftUI

struct CardView: View {
    
    @ObservedObject var viewModel: CardViewModel
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundColor(Color.lightCoalBlack)
                .frame(width: 320, height: screenSize().height >= 780 ? 420 : 320)
                .cornerRadius(20)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.lightGreen, lineWidth: 1)
                        .opacity(0.4)
                }
            
            
            
            VStack {
                
                Text(viewModel.word.wordValue)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: 250)
                
                if viewModel.translateIsShown {
                    Text(viewModel.word.wordTranslation)
                        //.font(.largeTitle)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .frame(width: 250)
                        .opacity(0.7)
                }
                
                
            }
            
            if !viewModel.translateIsShown {
                Button {
                    withAnimation {
                        viewModel.translateIsShown.toggle()
                    }
                } label: {
                    Image(systemName: "questionmark.circle")
                }
                .foregroundColor(Color.lightGreen)
                .offset(y: screenSize().height >= 780 ? 180 : 140)
            }
        }
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(viewModel: CardViewModel(word: Word.example))
            .preferredColorScheme(.dark)
    }
}
