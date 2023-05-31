//
//  FlashCardViewModel.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 19.04.2023.
//

import SwiftUI
import RealmSwift


class FlashCardViewModel: ObservableObject {
    
    @Binding var selectedWordList: WordList?
    
    @Published var index = 0
    @Published var isLast = false
    @Published var wordsToTraining = [Word]()
    @Published var prefix = 10
    
    func updateIndex() {
        index += 1
        if index == (selectedWordList?.words.count ?? 0) || index == prefix {
            isLast.toggle()
        }
    }
    
    func shuffleWords() {
        if let words = selectedWordList?.words {
            wordsToTraining = words.prefix(prefix).shuffled()
        }
    }
    
    init(selectedWordList: Binding<WordList?>) {
        self._selectedWordList = selectedWordList
        
    }
}



//    func test(length: Int)  {
//
//
//        let kek = WordList()
//        var newList = WordList().words
//
//        guard let list = selectedWordList?.words else { return }
//
//        while newList.count < length  {
//            for word in list {
//                switch word.wordWeight {
//                case 1...3:
//                    let randomCount = Int.random(in: 1...3)
//                    for _ in 1...randomCount {
//                        newList.append(word)
//                    }
//                case 4...7:
//                    newList.append(word)
//                case 8...9:
//                    if Bool.random() {
//                        newList.append(word)
//                    }
//                case 10: continue
//                default: break
//                }
//            }
//        }
//
//
//        wordsToTraining.words = newList
//        print(wordsToTraining.words.count)
//    }


//    func test(length: Int) -> WordList? {
//
//        var newList = WordList()
//
//        if let list = selectedWordList?.words {
//            while newList.words.count < length  {
//                for word in list {
//                    switch word.wordWeight {
//                    case 1...3:
//                        let randomCount = Int.random(in: 1...3)
//                        for _ in 1...randomCount {
//                            newList.words.append(word)
//                        }
//                    case 4...7:
//                        newList.words.append(word)
//                    case 8...9:
//                        if Bool.random() {
//                            newList.words.append(word)
//                        }
//                    case 10: continue
//                    default: break
//                    }
//                }
//            }
//        }
//        return newList
//    }



//    func generateKeysWordList(selectedWordList: WordList, length: Int) -> WordList {
//        let dictionaryArray = selectedWordList.words.map { ["wordValue": $0.wordValue, "wordWeight": $0.wordWeight] }
//        var keysArray: [String] = []
//
//        while keysArray.count <= length {
//            for dictionary in dictionaryArray {
//                guard let key = dictionary["wordValue"] as? String, let value = dictionary["wordWeight"] as? Int else {
//                    continue
//                }
//
//                switch value {
//                case 1...3:
//                    let randomCount = Int.random(in: 1...3)
//                    for _ in 1...randomCount {
//                        keysArray.append(key)
//                    }
//                case 4...7:
//                    keysArray.append(key)
//                case 8...9:
//                    if Bool.random() {
//                        keysArray.append(key)
//                    }
//                case 10: continue
//                default: break
//                }
//            }
//        }
//
//        let shuffledKeysArray = Array(keysArray.shuffled().prefix(length))
//        let newWordList = WordList()
//        newWordList.nameOfGroup = selectedWordList.nameOfGroup
//
//        for wordValue in shuffledKeysArray {
//            if let word = selectedWordList.words.first(where: { $0.wordValue == wordValue }) {
//                newWordList.words.append(word)
//            }
//        }
//
//        return newWordList
//    }
