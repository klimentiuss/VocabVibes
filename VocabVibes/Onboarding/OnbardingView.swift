//
//  OnbardingView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 22.06.2023.
//

import SwiftUI

struct OnbardingView: View {
    
    
    var completion: () -> ()
    @State var page = 0
    
    var body: some View {
        VStack {
            switch page {
            case 0...1:
                FirstOnboardingView() {
                    withAnimation {
                        page += 1
                    }
                }
            case 2:
                SecondOnboardingView {
                    withAnimation {
                        page += 1
                    }
                }
            case 3:
                ThirdOnboardingView() {
                    withAnimation {
                        page += 1
                    }
                }
            case 4:
                FourthOnboardingView() {
                    completion()
                }
            default:
                Text("error")
            }
            
            if page == 0 {
                Button {
                    completion()
                } label: {
                    Text("keySkip".localized)
                        .foregroundColor(.ratingRed)
                }
            }
            

        }
        
    }
}

struct OnbardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnbardingView(){}.preferredColorScheme(.dark)
    }
}
