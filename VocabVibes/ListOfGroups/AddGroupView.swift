//
//  AddGroupView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 05.11.2023.
//

import SwiftUI

struct AddGroupView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = AddGroupViewModel()
    
    var body: some View {
        VStack {
            Text("keyNewGroup".localized)
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color.lightGreen)
                .padding(.vertical, 10)
            
            VStack(alignment: .leading) {
                Text("Name of group:")
                    .opacity(0.5)
                TextField("keyGroupName".localized, text: $viewModel.groupName)
                    .autocorrectionDisabled()
                    .foregroundColor(Color.lightGreen)
                    .textFieldStyle(.roundedBorder)
                    .tint(Color.lightWhite)
                    .textInputAutocapitalization(.never)
                
                
                Text("Language you know:")
                    .opacity(0.5)
                Picker("", selection: $viewModel.mainLanguage) {
                    ForEach(Language.allCases, id: \.self) {
                        Text($0.description)
                           
                    }
                }
                .tint(Color.lightGreen)
                .background {
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundColor(.black)
                }
                
                
                Text("Language you want to learn:")
                    .opacity(0.5)
                Picker("", selection: $viewModel.learnLanguage) {
                    ForEach(Language.allCases, id: \.self) {
                        Text($0.description)
                            .bold()
                    }
                }
                .background {
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundColor(.black)
                }
                .tint(Color.lightGreen)
                
            }
            .font(.subheadline)
            
            
            
            
            VStack {
                Button("keySave".localized, action: {
                    viewModel.createNewGroup()
                    dismiss()
                })
                .buttonStyle(.bordered)
                .padding()
                Button("keyCancel".localized, role: .destructive) {
                    dismiss()
                }
            }
            
            
            
        }
        //.padding(.leading)
        .padding()
    }
}

struct AddGroupView_Previews: PreviewProvider {
    static var previews: some View {
        AddGroupView()
            .preferredColorScheme(.dark)
    }
}
