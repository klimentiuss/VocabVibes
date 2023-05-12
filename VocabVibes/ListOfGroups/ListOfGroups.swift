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
        UICollectionView.appearance().backgroundColor = UIColor(Color.darkGrayColor)
    }
    
    @ObservedObject var viewModel = ListOfGroupsViewModel()    

    var body: some View {
        ZStack {
            //Background
            BackgroundView()
            
            VStack(alignment: .leading) {
                HStack {
                    //Title
                    
                    Text("Word Groups")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                    
                    //Addition new group
                    Button {
                        viewModel.alertPresented.toggle()
                    } label: {
                        Text("Add new")
                            .foregroundColor(Color.tealColor)
                    }
                    
                    .alert("New Group", isPresented: $viewModel.alertPresented, actions: {
                        TextField("Group name", text: $viewModel.groupName)
                            .autocorrectionDisabled()
                        
                        Button("Save", action: {
                            viewModel.createNewGroup()
                        })
                        
                        Button("Cancel", role: .cancel, action: {})
                        
                    }, message: {
                        Text("Please enter name of new group.")
                    })
                }
                .padding(.horizontal, 20)
                .padding()
                
                List {
                    ForEach(viewModel.wordList.freeze(), id: \.id) { group in
                        GroupRow(viewModel: GroupRowViewModel(group: group))
                            .listRowBackground(Color.darkGrayColor)
                    }
                    .onDelete(perform: { indexSet in
                        viewModel.delete(at: indexSet)
                        
                    })
                }
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
                .padding(.top, -10)
                
            }
            .padding(.top, 10)
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
