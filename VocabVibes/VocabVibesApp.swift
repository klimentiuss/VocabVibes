//
//  VocabVibesApp.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 11.04.2023.
//

import SwiftUI
import RealmSwift

@main
struct VocabVibesApp: SwiftUI.App {

    var body: some Scene {
        WindowGroup {
            LaunchView()
                .preferredColorScheme(.dark)
                .onAppear {
                    print(Realm.Configuration.defaultConfiguration)
                }
        }
    }
    
    //Updating schema of Realm DB
    init() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    migration.enumerateObjects(ofType: WordList.className()) { _, newObject in
                        newObject!["languages"] = RealmSwift.List<WordListLanguage>()
                    }
                }
            }
        )
        Realm.Configuration.defaultConfiguration = config
        }
}
