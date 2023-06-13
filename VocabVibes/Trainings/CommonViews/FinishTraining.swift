//
//  FinishTraining.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 03.06.2023.
//

import SwiftUI

struct FinishTrainingView: View {
    
    var correctAnswersCount: Int
    var completion: () -> Void
    
    var body: some View {
        ZStack {
            if correctAnswersCount > 0 {
                CelebrationView()
            }
            VStack(alignment: .center) {
                Spacer()
                VStack {
                    Text("keyCorrectAnswers".localized)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                    Text("\(correctAnswersCount)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                }
                Button("keyGoback".localized) {
                    completion()
                }
                .foregroundColor(Color.lightGreen)
                .buttonStyle(.bordered)
                .padding()
                Spacer()
            }
        }
    }
}

struct FinishTrainingView_Previews: PreviewProvider {
    static var previews: some View {
        FinishTrainingView(correctAnswersCount: 1){}
            .preferredColorScheme(.dark)
    }
}
