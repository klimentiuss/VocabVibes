//
//  GroupDetail.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 15.04.2023.
//

import SwiftUI

struct GroupDetail: View {

    @ObservedObject var viewModel: GroupDetailViewModel
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                ScrollView {
                    VStack {
                        ForEach(viewModel.group.words, id: \.id) { word in
                            WordRow(viewModel: WordRowViewModel(word: word))
                        }
                    }
                    .padding()
                }
                
                Spacer()
//                CustomButton(textButton: "Learn", completion: {
//                    trainingsIsPressed.toggle()
//                })
//                .padding()
//                .sheet(isPresented: $trainingsIsPressed) {
//                    TrainingsScreen(isMain: false)
//                        .presentationDetents([.fraction(0.45)])
//                }
            }
            .toolbar {
                Button {
                    viewModel.getSelectedWordList()
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(Color.tealColor)
                }
                .sheet(isPresented: $viewModel.addNewWordIsPressed) {
                    if let list = viewModel.selectedWordList {
                        NewWordSreen(viewModel: NewWordSreenViewModel(selectedWordList: list))

                    }
                }
            }
        }
        .navigationTitle("\(viewModel.group.nameOfGroup)")
        .embedNavigationView(with: "\(viewModel.group.nameOfGroup)")
    }
}

struct GroupDetail_Previews: PreviewProvider {
    static var previews: some View {
        GroupDetail(viewModel: GroupDetailViewModel(group: WordList.example))
    }
}
