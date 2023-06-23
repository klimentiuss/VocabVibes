//
//  SecondOnboardingView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 22.06.2023.
//

import SwiftUI

struct SecondOnboardingView: View {
    
    @State private var isTextShown = false
    @State private var isButtonShown = false
    var completion: () -> ()
    
    
    var body: some View {
        VStack {
            //MARK: - Header
            VStack {
                Text("keyLearnWords".localized)
                    .multilineTextAlignment(.center)
                    .bold()
                    .font(.title)
            }
            .padding(.bottom, detectedSmallScreen(isWidthCheck: false) ? 0 : 40)
            
            //MARK: - Card
            ZStack {
                if isButtonShown {
                    Button {
                        withAnimation {
                            isButtonShown.toggle()
                            
                        }
                    } label: {
                        Text("keyTryAgain".localized)
                    }
                    .frame(width: 200, height: 316)
                } else {
                    SwipeCardView(width: 240, height: 300, viewModel: SwipeCardViewModel(word: Word.example)) {
                        isButtonShown.toggle()
                    }
                    .scaleEffect(CGFloat(detectedSmallScreen(isWidthCheck: false) ? 0.7 : 1))
                    //.offset(y: 10)
                    
                    .onAppear() {
                        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in
                            withAnimation {
                                isTextShown = true
                            }
                        }
                    }
                }
            }
            .padding(.bottom, detectedSmallScreen(isWidthCheck: false) ? 0 : 60)
            //MARK: - Instructions
            VStack(alignment: .listRowSeparatorLeading) {
                HStack {
                    Image(systemName: "hand.tap")
                    Text("keyTap".localized)
                }
                .opacity(isTextShown ? 1 : 0)
                .animation(Animation.easeInOut(duration: 0.6).delay(0.1), value: isTextShown)
                .padding(.bottom, 10)
                HStack {
                    Image(systemName: "arrowshape.turn.up.right")
                    Text("keySwipe".localized)
                }
                .opacity(isTextShown ? 1 : 0)
                .animation(Animation.easeInOut(duration: 0.6).delay(0.5), value: isTextShown)
                
                HStack {
                    Image(systemName: "arrowshape.turn.up.left")
                    Text("keyLeftSwipe".localized)
                }
                .opacity(isTextShown ? 1 : 0)
                .animation(Animation.easeInOut(duration: 0.6).delay(1), value: isTextShown)
                .padding(.top, 10)
            }
            .font(.system(size: 15))
            .padding(.horizontal, 20)
            //.padding(.top, 21)
            
            //MARK: - Next button
            Button {
                
                completion()
                
            } label: {
                Text("keyNext".localized)
            }
            .buttonStyle(.bordered)
            .padding(.top, 20)
        }
        
    }
}

struct SecondOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        SecondOnboardingView(){}.preferredColorScheme(.dark)
    }
}
