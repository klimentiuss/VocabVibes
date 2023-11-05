//
//  ListOfGroups.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 14.04.2023.
//

import SwiftUI
import RealmSwift

struct ListOfGroups: View {
    
    init() {
        UICollectionView.appearance().backgroundColor = UIColor(Color.coalBlack)
        UITextField.appearance().keyboardAppearance = .dark
    }
    
    @StateObject private var viewModel = ListOfGroupsViewModel()

    var body: some View {
        ZStack {
            //Background
            BackgroundView()
            
            VStack(alignment: .leading) {
                //MARK: - List of groups
                List {
                    ForEach(viewModel.wordGroups.freeze(), id: \.id) { group in
                        GroupRow(viewModel: GroupRowViewModel(group: group))
                            .swipeActions{
                                Button(role: .destructive) {
                                    viewModel.checkLastGroup(group: group)
                                    
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(Color.red)
                                
                                Button {
                                    viewModel.addViewPresented.toggle()

//                                    viewModel.threaded(group: group)
//                                    viewModel.prepareTextField(group: group)
//                                    viewModel.editingAlertPresented.toggle()
                                } label: {
                                    Image(systemName: "pencil")
                                }
                                .sheet(isPresented: $viewModel.addViewPresented) {
                                    AddGroupView()
                                        .presentationDetents([.medium, .large])
                                        .presentationDragIndicator(.visible)
                                }
                                .tint(Color.gray)
                            }
                            .listRowBackground(Color.coalBlack)
                        //MARK: - Alert with Editing
                            .alert("keyEdit".localized, isPresented: $viewModel.editingAlertPresented, actions: {
                                TextField("keyEnterNameOfGroup".localized, text: $viewModel.editingValue)
                                    .autocorrectionDisabled()
                                    .foregroundColor(.ratingEmerald)
                                
                                Button("keySave".localized, action: {
                                    StorageManager.shared.editGroup(
                                        selectedGroupRefOptional: viewModel.threadedGroup,
                                        newName: viewModel.editingValue)
                                })
                                
                                Button("keyCancel".localized, role: .cancel, action: {})
                                    
                            })
                            
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
                .alert("keyCantDeleteGroup".localized, isPresented: $viewModel.alertPresented) {}
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                     //   viewModel.addNewGroupPresented.toggle()
                        viewModel.addViewPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color.lightGreen)
                            .font(.system(size: detectedSmallScreen(isWidthCheck: false) ? 15 : 20))
                    }
                    .sheet(isPresented: $viewModel.addViewPresented) {
                        AddGroupView()
                            .presentationDetents([.medium, .large])
                            .presentationDragIndicator(.visible)
                    }
//                    .alert("keyNewGroup".localized, isPresented: $viewModel.addNewGroupPresented, actions: {
//                        TextField("keyGroupName".localized, text: $viewModel.groupName)
//                            .autocorrectionDisabled()
//                            .foregroundColor(.ratingEmerald)
//                        Button("keySave".localized, action: {
//                            viewModel.createNewGroup()
//                        })
//
//                        Button("keyCancel".localized, role: .cancel, action: {})
//
//                    }, message: {
//                        Text("keyEnterNameOfGroup".localized)
//                    })
                }
            }
        }
        .embedNavigationView(with: "keyWordGroups".localized)
    }
}

struct ListOfGroups_Previews: PreviewProvider {
    static var previews: some View {
        ListOfGroups()
    }
}

