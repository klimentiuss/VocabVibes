//
//  ListOfGroupsViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 14.04.2023.
//

import Foundation
import RealmSwift

class ListOfGroupsViewModel: ObservableObject {
    @ObservedResults(WordList.self) var wordList
    
    @Published var alertPresented = false
    @Published var groupName = ""
    
    func createNewGroup() {
        let newGroup = WordList()
        newGroup.nameOfGroup = groupName
        
        $wordList.append(newGroup)
        
        groupName = ""
    }
}
