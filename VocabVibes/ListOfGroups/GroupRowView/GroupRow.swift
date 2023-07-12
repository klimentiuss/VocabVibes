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
                GroupDetail(viewModel: GroupDetailViewModel(group: viewModel.group), isTextFieldsShown: false)
            } label: {
                ZStack {
                    Rectangle()
                        .fill(Color.lightCoalBlack)
                        .frame(height: 70)
                        .cornerRadius(20)
                        
                    
                    HStack {
                        Text(viewModel.group.nameOfGroup)
                            .foregroundColor(.lightWhite)
                            .font(.title2)
                        Spacer()
                        Text("\(viewModel.group.words.count)")
                            .foregroundColor(.lightWhite)
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


