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
        VStack(alignment: .center) {
            Spacer()
            Text("Correct Answers: \(correctAnswersCount)")
                .foregroundColor(.white)
                .font(.largeTitle)
                .bold()
            Button("Go back") {
                completion()
            }
            .foregroundColor(Color.lightGreen)
            .buttonStyle(.bordered)
            .padding()
            Spacer()
        }
    }
}

struct FinishTrainingView_Previews: PreviewProvider {
    static var previews: some View {
        FinishTrainingView(correctAnswersCount: 1){}
    }
}
