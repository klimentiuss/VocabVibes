//
//  TabMainView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 20.04.2023.
//

import SwiftUI



struct TabMainView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color.lightGrayColor)
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.tealColor.opacity(0.4))
        UITabBar.appearance().barTintColor = UIColor(Color.lightGrayColor)
    }
    
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("Main", systemImage: "figure.strengthtraining.traditional")
                }
            
            ListOfGroups()
                .tabItem {
                    Label("Groups", systemImage: "books.vertical.fill")
                }
            AllWordsView()
                .tabItem {
                    Label("Words", systemImage: "list.dash")
                }
        }
        .onAppear {
            DataManager.shared.createInitialList()
        }
        .tint(Color.tealColor)
        .embedNavigationView(with: "VocabVibes")
    }
}

struct TabMainView_Previews: PreviewProvider {
    static var previews: some View {
        TabMainView()
    }
}
