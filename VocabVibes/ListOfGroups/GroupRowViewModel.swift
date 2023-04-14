//
//  GroupRowViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 14.04.2023.
//

import Foundation

class GroupRowViewModel: ObservableObject {
    
    let group: WordList

    init(group: WordList) {
        self.group = group
    }
}
