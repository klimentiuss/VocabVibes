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
                .padding(.bottom, (detectedSmallScreen(isWidthCheck: false) ? -20 : 0))
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
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    HStack {
                        Image(systemName: "plus")
                        Text("keyTapPlus".localized)
                            .fixedSize(horizontal: false, vertical: true)
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
            .scaleEffect(CGFloat((detectedSmallScreen(isWidthCheck: false) ? 0.8 : 1)))
            
            //MARK: - Second Card
            VStack {
                Image("imgWords")
                    .resizable()
                    .frame(width: 250, height: 200)
                    .cornerRadius(20)
                HStack {
                    Image(systemName: "graduationcap")
                    Text("keyWatchWords".localized)
                        .fixedSize(horizontal: false, vertical: true)
                       // .padding()
                }
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.lightGreen, lineWidth: 1)
                    .opacity(0.4)
            }
            .scaleEffect(CGFloat((detectedSmallScreen(isWidthCheck: false) ? 0.8 : 1)))
            .padding(.top, (detectedSmallScreen(isWidthCheck: false) ? -40 : 0))
            //MARK: - Button
            Button {
                completion()
            } label: {
                Text("keyEndLearning".localized)
            }
            .buttonStyle(.bordered)
            .padding(.top, (detectedSmallScreen(isWidthCheck: false) ? -20 : 0))
        }
        .font(.system(size: 15))
        .padding()
    }
}

struct FourthOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        FourthOnboardingView(){}.preferredColorScheme(.dark)
    }
}
