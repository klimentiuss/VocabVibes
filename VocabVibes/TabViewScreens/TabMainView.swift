//
//  TabMainView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 20.04.2023.
//

import SwiftUI



struct TabMainView: View {
    
    init() {
//        UITabBar.appearance().backgroundColor = UIColor(Color.lightGrayColor)
//        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.tealColor.opacity(0.4))
//        UITabBar.appearance().barTintColor = UIColor(Color.lightGrayColor)
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
        .onAppear {
            DataManager.shared.createInitialList()
        }
        .tint(Color.lightGreen)
        .embedNavigationView(with: "VocabVibes")
    }
}

struct TabMainView_Previews: PreviewProvider {
    static var previews: some View {
        TabMainView()
    }
}
