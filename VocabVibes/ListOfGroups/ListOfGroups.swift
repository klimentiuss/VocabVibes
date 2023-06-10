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

//    @ObservedObject var viewModel = ListOfGroupsViewModel()

    var body: some View {
        ZStack {
            //Background
            BackgroundView()
            
            VStack(alignment: .leading) {
                HStack {
                    //Header
                    Text("Word Groups")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 10)
                        .padding(.leading, 20)
                        .padding(.bottom, -10)
                    
                    Spacer()
                    
                    //Addition new group
                    Button {
                        viewModel.addNewGroupPresented.toggle()
                    } label: {
                        Text("Add new")
                            .foregroundColor(Color.lightGreen)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    
                    .alert("New Group", isPresented: $viewModel.addNewGroupPresented, actions: {
                        TextField("Group name", text: $viewModel.groupName)
                            .autocorrectionDisabled()
                            .foregroundColor(.ratingEmerald)
                        Button("Save", action: {
                            viewModel.createNewGroup()
                        })
                        
                        Button("Cancel", role: .cancel, action: {})
                        
                    }, message: {
                        Text("Please enter name of new group.")
                    })
                    
                }

                //MARK: - List of groups
                List {
                    ForEach(viewModel.wordGroups.freeze(), id: \.id) { group in
                        GroupRow(viewModel: GroupRowViewModel(group: group))
                            .listRowBackground(Color.coalBlack)
                    }
                    .onDelete(perform: { indexSet in
                        //перенести
                        if viewModel.wordGroups.count > 1 {
                            viewModel.delete(at: indexSet)
                        } else {
                            VibrationManager.shared.simpleError()
                            viewModel.alertPresented.toggle()
                        }
                    })
                }
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
                .alert("You can't delete the last group", isPresented: $viewModel.alertPresented) {}
            }
            
        }
        .navigationTitle("Word groups")
        .embedNavigationView(with: "VocabVibes")
    }
}

struct ListOfGroups_Previews: PreviewProvider {
    static var previews: some View {
        ListOfGroups()
    }
}
