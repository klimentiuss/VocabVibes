//
//  WordGroup.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 11.04.2023.
//

import RealmSwift


class WordList: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var nameOfGroup: String = ""
    @Persisted var words = RealmSwift.List<Word>()
}


class Word: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId

    @Persisted var wordValue: String = ""
    @Persisted var wordTranslation: String = ""

}


#if DEBUG
// MARK: - Example Item

extension WordList {
    static var example: WordList {
        let list = WordList()
        list.nameOfGroup = "New Words"
        
        let word = Word()
        word.wordValue = "apple"
        word.wordTranslation = "яблоко"
        
        list.words.append(word)
        return list
        
    }
}

extension Word {
    static var example: Word {
            let word = Word()
            word.wordValue = "apple"
            word.wordTranslation = "яблоко"
            return word
        }
}
#endif
