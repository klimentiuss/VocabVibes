//
//  CardView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 19.04.2023.
//

import SwiftUI

struct SwipeCardView: View {
    
    @StateObject var viewModel: SwipeCardViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(viewModel.color)
                .frame(width: 350, height: 520)
                .cornerRadius(20)

            HStack {
                if viewModel.isTranslated {
                    Text(viewModel.translated)
                        .opacity(viewModel.isTranslated ? 1 : 0)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        //Mirror text
                        .rotation3DEffect(.degrees(Double(180)), axis: (x: 0, y: 1, z: 0))
                        .animation(.linear, value: viewModel.isTranslated)
                } else {
                    Text(viewModel.word)
                        .opacity(viewModel.isTranslated ? 0 : 1)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .animation(.linear, value: viewModel.isTranslated)
                }
            }
        }
        
        .rotation3DEffect(.degrees(Double(viewModel.rotation)), axis: (x: 0, y: 1, z: 0))
        .animation(.easeOut(duration: 0.4), value: viewModel.rotation)
        .onTapGesture {
            viewModel.rotation += 180
            viewModel.isTranslated.toggle()
        }
        
        //Card motion
        .offset(x: viewModel.offset.width, y: viewModel.offset.height * 0.4)
        .rotationEffect(.degrees(Double(viewModel.offset.width / 40)))
        .gesture(
            DragGesture()
                .onChanged{ gesture in
                    viewModel.offset = gesture.translation
                    withAnimation {
                        viewModel.changeColor(width: viewModel.offset.width)
                    }
                }
                .onEnded {_ in
                    withAnimation {
                        viewModel.swipeCard(width: viewModel.offset.width)
                        viewModel.changeColor(width: viewModel.offset.width)
                        
                    }
                }
        )
        
    }
}

struct SwipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeCardView(viewModel: SwipeCardViewModel(word: "Apple", translated: "Yabloko"))
    }
}