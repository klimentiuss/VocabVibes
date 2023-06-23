//
//  FirstOnboardingView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 22.06.2023.
//

import SwiftUI

struct FirstOnboardingView: View {
    @State private var angle = 60.0
    @State private var scale = 1.0
    @State private var isCardsShown = true
    var completion: () -> ()
    
    var body: some View {
        VStack {
            Spacer()
            //MARK: - Header
            if isCardsShown {
                Text("keyWelcome".localized)
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
            }
                
            Spacer()
            
            //MARK: - Logo/Card
            ZStack {
                ForEach(0 ..< 6) { item in
                    Rectangle()
                        .overlay {
                            
                            VStack {
                                Text(isCardsShown ? "" : "apple" )
                                    .bold()
                                    .foregroundColor(.white)
                                    .animation(.easeIn(duration: 1), value: isCardsShown)
                            }
                            
                            RoundedRectangle(cornerRadius: isCardsShown ? 20 : 10)
                                .stroke(
                                    isCardsShown ? Color.thinGreen : .lightGreen,
                                    lineWidth: isCardsShown ? 5 : 1
                                )
                                .opacity(0.4)
                            
                        }
                        .cornerRadius( isCardsShown ? 20 : 10)
                        .frame(width: 120, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor( isCardsShown ? .thinGreen : .lightCoalBlack)
                        .offset(y: isCardsShown
                                ? -80
                                : detectedSmallScreen(isWidthCheck: false) ? -90 : -80)
                        .rotationEffect(.degrees(Double(item)) * angle)
                        .scaleEffect(CGFloat(scale))
                        .blendMode(isCardsShown ? .screen : .normal)
                        .animation(.easeInOut(duration: 0.8), value: scale)
                }
            }
            .scaleEffect(CGFloat(detectedSmallScreen(isWidthCheck: false) ? 0.7 : 1))
            .offset(y: 50)
            //MARK: - Tagline
            if isCardsShown {
                Text("keyTagline".localized)
                    .foregroundColor(.lightWhite)
                    .padding(.top, 150)
                    .font(.system(size: detectedSmallScreen(isWidthCheck: false) ? 15 : 20))
                    .onDisappear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                           completion()
                        }
                        
                    }
            }
            
            //MARK: - Button
            Spacer()
            Button {
                withAnimation {
                    angle = 0.0
                    scale =  2
                    isCardsShown = false
                }
                completion()
                
            } label: {
                Text(isCardsShown ? "keyFindOut".localized : "keyNext".localized)
            }
            .buttonStyle(.bordered)
        }
        .padding(.bottom, 20)
    }
}

struct FirstOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        FirstOnboardingView(){}
            .preferredColorScheme(.dark)
    }
}
