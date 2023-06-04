//
//  View + Extantion.swift
//  MoviesApp
//
//  Created by Daniil Klimenko on 17.03.2023.
//  Copyright © 2023 Mohammad Azam. All rights reserved.
//

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
                    Color.lightCoalBlack,
                    for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(title)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color.lightGreen)
                        
                    }
                }
        }
        
    }
}

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}
