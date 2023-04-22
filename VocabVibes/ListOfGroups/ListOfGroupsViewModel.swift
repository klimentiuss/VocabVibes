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
        let trimmedGroupName = groupName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedGroupName.isEmpty else {
            groupName = ""
            return
        }
        
        let newGroup = WordList()
        newGroup.nameOfGroup = trimmedGroupName
        $wordList.append(newGroup)
        groupName = ""
    }
}
