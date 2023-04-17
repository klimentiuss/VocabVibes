//
//  GroupDetailViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 15.04.2023.
//

import Foundation
import RealmSwift

class GroupDetailViewModel: ObservableObject {
    
    @ObservedRealmObject var group: WordList
    
    @Published var trainingsIsPressed = false
    @Published var addNewWordIsPressed = false
    @Published var selectedWordList: WordList?
    
    
    func getSelectedWordList() {
        selectedWordList = group
        addNewWordIsPressed.toggle()
    }
    
    init(group: WordList) {
        self.group = group
    }
}
