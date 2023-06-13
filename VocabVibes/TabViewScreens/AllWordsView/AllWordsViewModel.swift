//
//  AllWordsViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 17.05.2023.
//

import Foundation
import RealmSwift

class AllWordsViewModel: ObservableObject {
    @ObservedResults(Word.self) var words
    
    func updateView() {
        objectWillChange.send()
        
    }
  
}
