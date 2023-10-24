//
//  TabMainView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 20.04.2023.
//

import SwiftUI

struct TabMainView: View {
    
    @State private var showingCredits = UserDefaults.standard.bool(forKey: "startLearning")
    
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color.lightCoalBlack)
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.thinGreen.opacity(0.4))
        UITabBar.appearance().barTintColor = UIColor(Color.lightCoalBlack)
    }
    
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("", systemImage: "figure.strengthtraining.traditional")
                }
            
            ListOfGroups()
                .tabItem {
                    Label("", systemImage: "rectangle.stack")
                }
            AllWordsView()
                .tabItem {
                    Label("", systemImage: "text.justify")
                        
                }
        }
        .sheet(isPresented: $showingCredits, content: {
            OnbardingView() {
                showingCredits.toggle()
            }
            .onDisappear {
                UserDefaults.standard.set(false, forKey: "startLearning")

            }
        })
        
        .tint(Color.lightGreen)
    }
}

struct TabMainView_Previews: PreviewProvider {
    static var previews: some View {
        TabMainView()
    }
}
