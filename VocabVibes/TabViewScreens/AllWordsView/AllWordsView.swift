//
//  AllWordView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 20.04.2023.
//

import SwiftUI

struct AllWordsView: View {
    var body: some View {
        ZStack {
            BackgroundView()
        }
        .navigationTitle("All words")
        .embedNavigationView(with: "All words")
    }
}

struct AllWordView_Previews: PreviewProvider {
    static var previews: some View {
        AllWordsView()
    }
}
