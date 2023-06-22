//
//  LaunchView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 12.06.2023.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var isActive = true
    @State private var angle = 0.0
    @State private var scale = 0.0
    @State private var isCardsShown = false
    
    var body: some View {
        if isActive {
            ZStack {
                BackgroundView()
                VStack {
                    Spacer()
                    ZStack {
                        ForEach(0 ..< 6) { item in
                            Rectangle()
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.lightGreen, lineWidth: 5)
                                        .opacity(0.4)
                                    
                                }
                                .cornerRadius(20)
                                .frame(width: 120, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.thinGreen)
                                .offset(y: isCardsShown ? -130 : -80)
                                .rotationEffect(.degrees(Double(item)) * angle)
                                .scaleEffect(CGFloat(scale))
                                .blendMode(.screen)
                            
                                .animation(.easeInOut(duration: 0.8), value: scale)
                                .onAppear() {
                                    angle = 60.0
                                    scale = 1
                                    
                                }
                        }
                    }
                    .scaleEffect(isCardsShown ? 10 : 1)
                    .onAppear {
                        DataManager.shared.createInitialList()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                isCardsShown.toggle()
    
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.26 ) {
                            withAnimation {
                                isActive.toggle()
                            }
                        }
                        
                        
                    }
                    Spacer()
                }
            }
        } else {
            TabMainView()
                .opacity(isActive ? 0 : 1)
                
                
        }
        
    }
    
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            .preferredColorScheme(.dark)
    }
}
