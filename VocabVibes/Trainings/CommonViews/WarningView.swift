//
//  WarningView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 03.06.2023.
//

import SwiftUI

struct WarningView: View {
    
    var completion: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            Text("keyFewWords".localized)
                .font(.title)
                .foregroundColor(.white)
                .bold()
            
            VStack(alignment: .center) {
                
                Button("keyGoback".localized) {
                    completion()
                }
                .foregroundColor(.lightGreen)
                .buttonStyle(.bordered)
                .padding()
            }
            Spacer()
        }
    }
}

struct WarningView_Previews: PreviewProvider {
    static var previews: some View {
        WarningView(){}
    }
}
