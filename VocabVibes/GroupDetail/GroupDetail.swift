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
                                
                                WordRow(
                                    viewModel: WordRowViewModel(word: word),
                                    height: word.wordValue.count > 30 ? 85 : 60)
                                //MARK: - Swipe Actions
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            StorageManager.shared.deleteWord(word: word)
                                        } label: {
                                            Image(systemName: "trash")
                                        }
                                        
                                        Button {
                                            viewModel.threaded(word: word)
                                            viewModel.prepareTextFields(word: word)
                                            viewModel.alertPresented.toggle()
                                        } label: {
                                            Image(systemName: "pencil")
                                        }
                                    }
                                    .listRowBackground(Color.coalBlack)
                                //MARK: - Alert with Editing
                                    .alert("keyEdit".localized, isPresented: $viewModel.alertPresented, actions: {
                                        TextField("keyWord".localized, text: $viewModel.editingValue)
                                            .autocorrectionDisabled()
                                            .foregroundColor(.ratingEmerald)
                                        TextField("keyTranslate".localized, text: $viewModel.editingTranslation)
                                            .autocorrectionDisabled()
                                            .foregroundColor(.ratingEmerald)
                                        
                                        Button("keySave".localized, role: .cancel, action: {
                                            StorageManager.shared.editWord(
                                                selectedWordRefOptional: viewModel.threadedWord,
                                                value: viewModel.editingValue,
                                                translation: viewModel.editingTranslation)
                                            
                                        })
                                        
                                        Button("keyCancel".localized, role: .cancel, action: {})
                                            
                                    }, message: {
                                        Text("keyEditMessage".localized)
                                    })
                                
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
