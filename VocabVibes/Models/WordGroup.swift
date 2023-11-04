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
    @Persisted var languages = RealmSwift.List<WordListLanguage>()
}


class Word: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId

    @Persisted var wordWeight: Int = 0
    @Persisted var wordValue: String = ""
    @Persisted var wordTranslation: String = ""
}

class WordListLanguage: Object, ObjectKeyIdentifiable {
    @Persisted var mainLanguage: String?
    @Persisted var languageToLearn: String?
}

enum Language: String, CaseIterable, Identifiable, CustomStringConvertible {
    var id: Self { self }
    case en, uk, cs, de, pl, it, es, fr
    
    var description: String {
        switch self {
        case .en:
           return "English"
        case .uk:
            return "Ukrainian"
        case .cs:
            return "Czech"
        case .de:
            return "Deutch"
        case .pl:
            return "Polish"
        case .it:
            return "Italian"
        case .es:
            return "Spanish"
        case .fr:
            return "French"
        }
    }
}

// MARK: - Example Item

extension WordList {
    static var example: WordList {
        let list = WordList()
        list.nameOfGroup = "New Words"
        
        let word = Word()
        word.wordValue = "apple"
        word.wordTranslation = "яблуко"
        word.wordWeight = 8
        
        for _ in 1..<15 {
            list.words.append(word)
        }
        
        return list
        
    }
}

extension Word {
    static var example: Word {
            let word = Word()
            word.wordValue = "Arbeitsunfähigkeitsbescheinigung"
            word.wordTranslation = "Arbeitsunfähigkeitsbescheinigung"
            word.wordWeight = 8
            return word
        }
}
