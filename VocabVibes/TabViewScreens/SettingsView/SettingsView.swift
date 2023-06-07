//
//  SettingsView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 20.04.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        ZStack {
            BackgroundView()
            Form {
                Section(content: {
                    Toggle("Haptic", isOn: $viewModel.switcher)
                    
                    Picker("Select Number", selection: $viewModel.wordsPerTraining) {
                        ForEach(viewModel.trainingOptions, id: \.self) { number in
                            Text("\(number)")
                        }
                    }
                    .preferredColorScheme(.dark)
                    .pickerStyle(.menu)
                }, header: {
                    Text("Trainings")
                }, footer: {
                    Text("Setting up words in training implies using the maximum number of words from the group.")
                })
                .listRowBackground(Color.lightCoalBlack)
                
                
                Section("Localization") {
                    Picker("Language", selection: $viewModel.languages) {
                        ForEach(viewModel.languages, id: \.self) { value in
                            Text(value)
                        }
                    }
                    .preferredColorScheme(.dark)
                    .pickerStyle(.menu)
                }
                .listRowBackground(Color.lightCoalBlack)
            }
            
            .tint(.ratingEmerald)
            .foregroundColor(.lightWhite)
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Settings")
        .embedNavigationView(with: "Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
