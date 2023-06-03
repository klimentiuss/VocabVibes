//
//  CustomButton.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 03.06.2023.
//

import SwiftUI

struct CustomButtonView: View {
    
    var buttonIcon: String
    var size: CGFloat
    var color: Color
    var completion: () -> Void
    
    
    var body: some View {
        Button {
            completion()
        } label: {
            Rectangle()
                .frame(width: 80, height: 80)
                .cornerRadius(20)
                .foregroundColor(Color.lightGrayColor)
                .overlay {
                    Image(systemName: buttonIcon)
                        .resizable()
                        .foregroundColor(color)
                        .frame(width: size, height: size)
                }
        }
    }
}

struct CustomButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonView(buttonIcon: "rectangle.portrait.and.arrow.right", size: 40, color: .red){}
    }
}
