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
    @State var isTextFieldsShown: Bool
    
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                withAnimation {
                    //MARK: - Adding new words
                    VStack {
                        AddNewWordsView(viewModel: viewModel) {
                            viewModel.offsetMove = viewModel.addNewWordIsPressed ?  0 : -110
                            isTextFieldsShown.toggle()
                        }
                        if viewModel.isSearchShown {
                            Text("")
                                .searchable(text: $viewModel.searchWord, placement: .navigationBarDrawer(displayMode: .always))
                        }
                        //MARK: - List of words
                        List {
                            ForEach(viewModel.search(by: viewModel.searchWord, in: viewModel.group), id: \.id) { word in
                                
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
                                    .tint(Color.red)
                                    Button {
                                        viewModel.threaded(word: word)
                                        viewModel.prepareTextFields(word: word)
                                        viewModel.alertPresented.toggle()
                                    } label: {
                                        Image(systemName: "pencil")
                                    }
                                    .tint(Color.gray)
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
                                    
                                    Button("keySave".localized, action: {
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
                    .animation(.linear, value: viewModel.offsetMove)
                    .offset(y:viewModel.offsetMove)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                if viewModel.isSearchShown {
                                    viewModel.isSearchShown.toggle()
                                }
                                viewModel.showOrHide()
                                isTextFieldsShown.toggle()
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(Color.lightGreen)
                                    .rotationEffect(.degrees(viewModel.addNewWordIsPressed ? 40 : 0))
                                    .animation(.easeIn, value: viewModel.addNewWordIsPressed)
                            }
                        }
                        
                        ToolbarItem(placement: .navigationBarLeading ) {
                            Button {
                                withAnimation {
                                    if isTextFieldsShown {
                                        viewModel.showOrHide()
                                        isTextFieldsShown = false
                                    }
                                    viewModel.isSearchShown.toggle()
                                }
                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(Color.lightGreen)
                            }
                        }
                        
                    }
                    
                }
            }
        }
        .onAppear { // fires when the add word button is pressed from the PickerView
            if isTextFieldsShown {
                viewModel.showOrHide()
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
