//
//  ListOfGroups.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 14.04.2023.
//

import SwiftUI

struct ListOfGroups: View {
    
    
    @ObservedObject private var viewModel = ListOfGroupsViewModel()
    
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
                
                ScrollView {
                    VStack{
                        ForEach(viewModel.wordList, id: \.id) { group in
                            GroupRow(viewModel: GroupRowViewModel(group: group))
                                
                        }
                    }
                }
                .padding(.top, -10)
                .padding(.horizontal, 20)
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
