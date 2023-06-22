//
//  FourthOnboardingView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 22.06.2023.
//

import SwiftUI

struct FourthOnboardingView: View {
    
    var completion: () -> ()
    
    var body: some View {
        VStack {
            //MARK: - Header
            Text("keyMakeAndWatch".localized)
                .multilineTextAlignment(.center)
                .bold()
                .font(.title)
            Spacer()
            
            //MARK: - First card
            VStack {
                Image("imgGroup")
                    .resizable()
                    .frame(width: 250, height: 150)
                    .cornerRadius(20)
                VStack(alignment: .listRowSeparatorLeading) {
                    HStack {
                        Image(systemName: "hand.tap")
                        Text("keyChooseGroupBeforeTrainig".localized)
                    }
                    
                    HStack {
                        Image(systemName: "plus")
                        Text("keyTapPlus".localized)
                    }
                    .padding(.top, 10)
                }
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.lightGreen, lineWidth: 1)
                    .opacity(0.4)
            }
            
            //MARK: - Second Card
            Spacer()
            VStack {
                Image("imgWords")
                    .resizable()
                    .frame(width: 250, height: 200)
                    .cornerRadius(20)
                HStack {
                    Image(systemName: "graduationcap")
                    Text("keyWatchWords".localized)
                        .padding()
                }
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.lightGreen, lineWidth: 1)
                    .opacity(0.4)
            }
            
            //MARK: - Button
            Spacer()
            Button {
                completion()
            } label: {
                Text("keyEndLearning".localized)
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

struct FourthOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        FourthOnboardingView(){}.preferredColorScheme(.dark)
    }
}
