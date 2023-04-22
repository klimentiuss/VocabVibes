//
//  SharedViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 21.04.2023.
//

import SwiftUI


class SharedViewModel: ObservableObject {
    
    @Published var currentCardIndex = 0
    @Published var correctAnswersCount = 0
    @Published var isLast = false
    
}
