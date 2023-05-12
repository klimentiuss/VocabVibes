//
//  View + Extantion.swift
//  MoviesApp
//
//  Created by Daniil Klimenko on 17.03.2023.
//  Copyright © 2023 Mohammad Azam. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    
    func screenSize() -> CGSize {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return window.screen.bounds.size
    }
    
    func embedNavigationView(with title: String) -> some View {
        return NavigationStack {
            self
                .toolbarBackground(
                    Color.lightGrayColor,
                    for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(title).font(.largeTitle).bold()
                            .foregroundColor(Color(#colorLiteral(red: 0, green: 0.8285897374, blue: 0.7882844806, alpha: 1)))
                        
                    }
                }
        }
        
    }
}

