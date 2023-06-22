//
//  ListOfGroupsViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 14.04.2023.
//

import Foundation
import RealmSwift

class ListOfGroupsViewModel: ObservableObject {
    @ObservedResults(WordList.self) var wordGroups
    
    @Published var alertPresented = false
    @Published var addNewGroupPresented = false
    @Published var groupName = ""
    
    
    func createNewGroup() {
        let trimmedGroupName = groupName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedGroupName.isEmpty else {
            groupName = ""
            return
        }
        
        let newGroup = WordList()
        newGroup.nameOfGroup = trimmedGroupName
        
        $wordGroups.append(newGroup)
        groupName = ""
    }
    
    func checkLastGroup(indexSet: IndexSet) {
        if wordGroups.count > 1 {
            delete(at: indexSet)
        } else {
            VibrationManager.shared.makeVibration(with: true)
            alertPresented.toggle()
        }
    }
    
    func delete(at indexSet: IndexSet) {
        if let index = indexSet.first,
            let realm = wordGroups[index].realm {
            try? realm.write({
                realm.delete(wordGroups[index].words)
                realm.delete(wordGroups[index])
            })
            objectWillChange.send()
        }
    }
    
}
