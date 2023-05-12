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
    
    var body: some View {
        ZStack {
            BackgroundView()
            withAnimation {
                VStack {
                   //перенести в отдельное вью
                    VStack {
                        VStack(alignment: .leading) {
                            TextField("Word", text: $viewModel.word)
                            
                                .tint(Color.black)
                                .textFieldStyle(.roundedBorder)
                                .autocorrectionDisabled()
                                .keyboardType(.asciiCapable)
                                .toolbar {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        HStack {
                                            Button("Close") {
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                viewModel.getSelectedWordList()
                                                offsetMove = viewModel.addNewWordIsPressed ?  0 : -110
                                            }
                                            .foregroundColor(.red)
                                            Spacer()
                                            Button("Save") {
                                                viewModel.checkTextFieldsAndSave()
                                            }
                                        }
                                    }
                                }
                            TextField("Translate", text: $viewModel.transalte)
                                .tint(Color.black)
                                .textFieldStyle(.roundedBorder)
                                .autocorrectionDisabled()
                                .keyboardType(.asciiCapable)
                        }
                        .padding()
                    }
                    
                    
                    
                    List {
                        ForEach(viewModel.group.words, id: \.id) { word in
                            WordRow(viewModel: WordRowViewModel(word: word))
                                .listRowBackground(Color.darkGrayColor)
                        }
                        .onDelete { indexSet in
                            viewModel.delete(at: indexSet)
                        }
                    }
                    .background(Color.darkGrayColor)
                    .listStyle(.plain)
                }
                .animation(.easeIn, value: offsetMove)
                .offset(y:offsetMove)
                .toolbar {
                    Button {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        viewModel.getSelectedWordList()
                        offsetMove = viewModel.addNewWordIsPressed ?  0 : -110
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color.tealColor)
                            .rotationEffect(.degrees(viewModel.addNewWordIsPressed ? 40 : 0))
                            .animation(.easeIn, value: viewModel.addNewWordIsPressed)
                    }
                }
            }
        }
        .onAppear {
            viewModel.getSelectedWordList()
        }
        .navigationTitle("\(viewModel.group.nameOfGroup)")
        .embedNavigationView(with: "\(viewModel.group.nameOfGroup)")
    }
}

struct GroupDetail_Previews: PreviewProvider {
    static var previews: some View {
        GroupDetail(viewModel: GroupDetailViewModel(group: WordList.example, selectedWordList: WordList.example))
    }
}
