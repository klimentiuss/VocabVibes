//
//  GroupRow.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 14.04.2023.
//

import SwiftUI

struct GroupRow: View {
        
    @ObservedObject var viewModel: GroupRowViewModel
        
    var body: some View {
        ZStack {
            NavigationLink {
                GroupDetail(viewModel: GroupDetailViewModel(group: viewModel.group))
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
                        Text("\(viewModel.group.words.count)")
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
    }
}

struct GroupRow_Previews: PreviewProvider {
    static var previews: some View {
        GroupRow(viewModel: GroupRowViewModel(group: WordList.example))
    }
}


