//
//  GroupDetailSecond.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 07.05.2023.
//

import SwiftUI
import RealmSwift

struct GroupDetail: View {
    
    
    @ObservedObject var viewModel: GroupDetailViewModel
    @State var offsetMove: CGFloat = -110
    @State var isTextFieldsShown: Bool
        
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                withAnimation {
                    //MARK: - Adding new words
                    VStack {
                        AddNewWordsView(viewModel: viewModel) {
                            offsetMove = viewModel.addNewWordIsPressed ?  0 : -110
                        }
                    //MARK: - List of words
                        List {
                            ForEach(viewModel.group.words, id: \.id) { word in
                                WordRow(viewModel: WordRowViewModel(word: word))
                                    .listRowBackground(Color.coalBlack)
                            }
                            .onDelete { indexSet in
                                viewModel.delete(at: indexSet)
                            }
                        }
                        .background(Color.coalBlack)
                        .listStyle(.plain)
                    }
                    .padding(.bottom, viewModel.addNewWordIsPressed ?  0 : -90)
                    .animation(.linear, value: offsetMove)
                    .offset(y:offsetMove)
                    .toolbar {
                        Button {
                            viewModel.showOrHide()
                            offsetMove = viewModel.addNewWordIsPressed ?  0 : -110
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(Color.lightGreen)
                                .rotationEffect(.degrees(viewModel.addNewWordIsPressed ? 40 : 0))
                                .animation(.easeIn, value: viewModel.addNewWordIsPressed)
                        }
                    }
                    
                }
            }
            
            
        }
        .onAppear {
            if isTextFieldsShown {
                viewModel.showOrHide()
                offsetMove = viewModel.addNewWordIsPressed ?  0 : -110
            }
        }
        .navigationTitle("\(viewModel.group.nameOfGroup)")
        .embedNavigationView(with: "\(viewModel.group.nameOfGroup)")
    }
}

//struct GroupDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupDetail(viewModel: GroupDetailViewModel(group: WordList.example), isTextFieldsShown: false)
//    }
//}
