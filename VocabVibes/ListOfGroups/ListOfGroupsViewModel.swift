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
    @Published var threadedGroup: ThreadSafeReference<WordList>?
    @Published var editingAlertPresented = false
    @Published var editingValue = ""
    
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
    
    func checkLastGroup(group: WordList) {
        if wordGroups.count > 1 {
            StorageManager.shared.deleteGroup(group: group)
        } else {
            VibrationManager.shared.makeVibration(with: true)
            alertPresented.toggle()
        }
        objectWillChange.send()
    }

    func threaded(group: WordList){
        threadedGroup = ThreadSafeReference(to: group)
    }
    
    func prepareTextField(group: WordList) {
        editingValue = group.nameOfGroup
    }
}
