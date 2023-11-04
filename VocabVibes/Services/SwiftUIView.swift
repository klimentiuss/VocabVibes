//
//  SwiftUIView.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 04.11.2023.
//

import SwiftUI
import AVFoundation

//en, uk, cs, de, pl, it, es, fr


struct SwiftUIView: View {
    
    @StateObject private var synthesizer = SpeechSynthesizer()
    @State private var textToSpeech = ""
    @State private var selectedLanguage: Language = .cs
    
    
    var body: some View {
        VStack {
            Text(selectedLanguage.rawValue)
            Picker("", selection: $selectedLanguage) {
                ForEach(Language.allCases, id: \.self) {
                    Text($0.description)
                }
            }
            
            TextField("", text: $textToSpeech)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button {
                Task {
                  //  await synthesizer.speak(textToSpeech)
                    await synthesizer.speak(_: textToSpeech, language: selectedLanguage)
                }
            } label: {
                Text("kek")
            }

        }
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
