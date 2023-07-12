//
//  SettingsView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 20.04.2023.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    
    @Environment(\.requestReview) var requestReview
    @StateObject private var viewModel = SettingsViewModel()
    @State private var showingCredits = false
    @State private var showingMailWithError = false
    @State private var showingMailWithSuggestion = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            Form {
                // MARK: - TRAININGS
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
                
                // MARK: - APPLICATION
                Section(content: {
                    Button(action: {
                        showingCredits.toggle()
                    }, label: {
                        HStack {
                            Text("keyWatchTutorial".localized)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    })
                    .sheet(isPresented: $showingCredits, content: {
                        OnbardingView {
                            showingCredits.toggle()
                        }
                    })
                    .buttonStyle(.plain)
                    .preferredColorScheme(.dark)
                    
                    Toggle("keySensitive".localized, isOn: $viewModel.upperCaseSwitcher)
                    
                }, header: {
                    Text("keyApplication".localized)
                }, footer: {
                    Text("keyRegisterWords".localized)
                })
                .listRowBackground(Color.lightCoalBlack)
                
                // MARK: - SUPPORT
                Section(content: {
                    Button(action: {
                        requestReview()
                    }, label: {
                        HStack {
                            Text("keyRate".localized)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    })
                    
                    Button(action: {
                        showingMailWithError.toggle()
                    }, label: {
                        HStack {
                            Text("keyBug".localized)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    })
                    .sheet(isPresented: $showingMailWithError) {
                        MailComposeView(isShowing: $showingMailWithError, subject: "Error message", recipientEmail: "memrixApp@icloud.com")
                    }
                    
                    Button(action: {
                        showingMailWithSuggestion.toggle()
                    }, label: {
                        HStack {
                            Text("keySuggest".localized)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    })
                    .sheet(isPresented: $showingMailWithSuggestion) {
                        MailComposeView(isShowing: $showingMailWithSuggestion, subject: "Improvement suggestion", recipientEmail: "memrixApp@icloud.com")
                    }
                    
                    .buttonStyle(.plain)
                    .preferredColorScheme(.dark)
                    .pickerStyle(.menu)
                }, header: {
                    Text("keySuport".localized)
                }, footer: {
                    Text("")
                })
                .listRowBackground(Color.lightCoalBlack)
                
                // MARK: - USAGE
                Section(content: {
                    Button(action: {
                        viewModel.openPrivacyPolicy()
                    }, label: {
                        Text("keyPrivacy".localized)
                        Spacer()
                        Image(systemName: "chevron.right")
                    })
                  
                    .buttonStyle(.plain)
                    .preferredColorScheme(.dark)
                    .pickerStyle(.menu)
                }, header: {
                    Text("keyUsage".localized)
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








