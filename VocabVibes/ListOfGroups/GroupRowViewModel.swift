//
//  GroupRowViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 14.04.2023.
//

import SwiftUI

class GroupRowViewModel: ObservableObject {
    
    @Published var group: WordList
    @Published var wordsCount: Int

 
    
    init(group: WordList) {
        self.group = group
        wordsCount = group.words.count
    }
    
    func updateWordsValue() {
        wordsCount = group.words.count
    }
}
