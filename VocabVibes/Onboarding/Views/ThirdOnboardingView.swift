//
//  ThirdOnboardingView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 22.06.2023.
//

import SwiftUI

struct ThirdOnboardingView: View {
    
    @State private var selectedTab = 0
    var completion: () -> ()
    
    var body: some View {
        VStack {
            //MARK: - Header
            Text("keyTrainingWords".localized)
                .multilineTextAlignment(.center)
                .bold()
                .font(.title)
                .padding(.top, 0)
            
            //MARK: - Page View
            TabView(selection: $selectedTab) {
                VStack {
                    Image("imgSelect")
                        .resizable()
                        .frame(width: 270, height: 450)
                        .cornerRadius(20)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.lightGreen, lineWidth: 1)
                                .opacity(0.4)
                        }
                        .scaleEffect(CGFloat(detectedSmallScreen(isWidthCheck: false) ? 0.7 : 1))
                        .padding(.bottom,(detectedSmallScreen(isWidthCheck: false) ? -20 : 20))
                    
                    
                    Text("keyChooseRightWord".localized)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer(minLength:(detectedSmallScreen(isWidthCheck: false) ? 120 : 70))
                }
                .tabItem {
                    Text("Page 1")
                }
                .tag(0)
                
                
                VStack {
                    Image("imgMake")
                        .resizable()
                        .frame(width: 270, height: 450)
                        .cornerRadius(20)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.lightGreen, lineWidth: 1)
                                .opacity(0.4)
                        }
                        .scaleEffect(CGFloat(detectedSmallScreen(isWidthCheck: false) ? 0.7 : 1))
                        .padding(.bottom,(detectedSmallScreen(isWidthCheck: false) ? -20 : 20))
                    Text("keyMakeWordFromLetters".localized)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer(minLength:(detectedSmallScreen(isWidthCheck: false) ? 120 : 60))
                }
                .tabItem {
                    Text("Page 1")
                }
                .tag(1)
                
                VStack {
                    Image("imgWrite")
                        .resizable()
                        .frame(width: 270, height: 450)
                        .cornerRadius(20)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.lightGreen, lineWidth: 1)
                                .opacity(0.4)
                        }
                        .scaleEffect(CGFloat(detectedSmallScreen(isWidthCheck: false) ? 0.7 : 1))
                        .padding(.bottom,(detectedSmallScreen(isWidthCheck: false) ? -60 : 10))
                    Text("keyWriteWordInTextFiedl".localized)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                    
                    if selectedTab >= 1 {
                        Button {
                            completion()
                        } label: {
                            Text("keyNext".localized)
                        }
                        .buttonStyle(.bordered)
                        .padding(.bottom, (detectedSmallScreen(isWidthCheck: false) ? 50 : 0))
                    }
                    Spacer(minLength: 50)
                }
                .tabItem {
                    Text("Page 3")
                }
                .tag(2)
            }
            .font(.system(size: (detectedSmallScreen(isWidthCheck: true) ? 15 : 20)))
            .tabViewStyle(.page(indexDisplayMode: .always))
            
        }
        .padding()
    }
}

struct ThirdOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdOnboardingView(){}.preferredColorScheme(.dark)
    }
}
