//
//  SettingsView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 20.04.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @State private var showingCredits = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            Form {
                Section(content: {
                    Toggle("keyHaptic".localized, isOn: $viewModel.switcher)
                    
                    Picker("keyWordsInTraining".localized, selection: $viewModel.wordsPerTraining) {
                        ForEach(viewModel.trainingOptions, id: \.self) { number in
                            Text("\(number)")
                        }
                    }
                    .preferredColorScheme(.dark)
                    .pickerStyle(.menu)
                }, header: {
                    Text("keyTrainings".localized)
                }, footer: {
                    Text("keySettingsWarning".localized)
                })
                .listRowBackground(Color.lightCoalBlack)
                
                Section(content: {
                    Button(action: {
                        showingCredits.toggle()
                    }, label: {
                        Text("keyWatchTutorial".localized)
                    })
                    .sheet(isPresented: $showingCredits, content: {
                        OnbardingView {
                            showingCredits.toggle()
                        }
                    })
                    .preferredColorScheme(.dark)
                    .pickerStyle(.menu)
                }, header: {
                    Text("keyApp".localized)
                }, footer: {
                    Text("")
                })
                .listRowBackground(Color.lightCoalBlack)
            }
            .tint(.ratingEmerald)
            .foregroundColor(.lightWhite)
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("keySettings".localized)
        .embedNavigationView(with: "keySettings".localized)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
