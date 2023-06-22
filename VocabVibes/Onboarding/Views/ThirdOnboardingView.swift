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
            Spacer()
            
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
                    Text("keyChooseRightWord".localized)
                        .multilineTextAlignment(.center)
                        .padding()
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
                    Text("keyMakeWordFromLetters".localized)
                        .multilineTextAlignment(.center)
                        .padding()
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
                    Text("keyWriteWordInTextFiedl".localized)
                        .multilineTextAlignment(.center)
                        .padding()
                    if selectedTab == 2 {
                        Button {
                            completion()
                        } label: {
                            Text("keyNext".localized)
                        }
                        .buttonStyle(.bordered)
                        .padding(.bottom, 30)
                    }
                }
                .tabItem {
                    Text("Page 3")
                }
                .tag(2)
            }
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
