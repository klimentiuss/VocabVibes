//
//  GroupRow.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 14.04.2023.
//

import SwiftUI

struct GroupRow: View {
    
//    @State var offsetX: CGFloat = 0
    
    @ObservedObject var viewModel: GroupRowViewModel
        
    var body: some View {
        ZStack {
            NavigationLink {
                GroupDetail(viewModel: GroupDetailViewModel(group: viewModel.group, selectedWordList: viewModel.group))
             //   GroupDetail(viewModel: GroupDetailViewModel(group: viewModel.group))
            } label: {
                ZStack {
                    Rectangle()
                        .fill(Color.lightGrayColor)
                        .frame(height: 70)
                        .opacity(0.8)
                        .cornerRadius(20)
                        
                    
                    HStack {
                        Text(viewModel.group.nameOfGroup)
                            .foregroundColor(.white)
                            .font(.title2)
                        Spacer()
                        Text("\(viewModel.wordsCount)")
                            .foregroundColor(.black)
                            .opacity(0.3)
                    }
                    .padding()
                }
            }
            .onAppear {
                viewModel.updateWordsValue()

            }
        }
//        .offset(x: offsetX)
//        .gesture(DragGesture()
//            .onChanged{ value in
//                if value.translation.width < 0 {
//                    offsetX = value.translation.width
//
//                }
//            }
//                .onEnded{ value in
//                    withAnimation {
//                        offsetX = 0
//                    }
//                }
//        )
       

    }
}

struct GroupRow_Previews: PreviewProvider {
    static var previews: some View {
        GroupRow(viewModel: GroupRowViewModel(group: WordList.example))
    }
}


extension View {
    func screenSize() -> CGSize {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return window.screen.bounds.size
    }
}
