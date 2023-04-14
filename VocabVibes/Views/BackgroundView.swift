//
//  BackgroundView.swift
//  CustomTableView
//
//  Created by Daniil Klimenko on 23.03.2023.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(Color.darkGrayColor)
            .ignoresSafeArea()
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
