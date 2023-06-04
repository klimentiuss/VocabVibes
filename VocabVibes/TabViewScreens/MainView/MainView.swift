//
//  MainView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 20.04.2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TrainingsScreen(viewModel: TrainingsScreenViewModel(isMain: true))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(Color.lightGreen)
                    }
                }
            }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
