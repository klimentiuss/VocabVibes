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
    
    func delete(at indexSet: IndexSet) {
        if let index = indexSet.first,
            let realm = wordList[index].realm {
            try? realm.write({
                realm.delete(wordList[index])
            })
            objectWillChange.send()
        }
    }

    
    //    func deleteList(_ list: WordList) {
    //
    //        let realm = try! Realm()
    //
    //        do {
    //            try realm.write {
    //                realm.delete(list.words)
    //                realm.delete(list)
    //            }
    //        } catch {
    //            print("Error adding word: \(error.localizedDescription)")
    //        }
    //      //  wordList = realm.objects(WordList.self)
    //        //$wordList.remove(list)
    //    }
    
}
