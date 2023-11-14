//
//  UserDefaultModel.swift
//  GameMonsters
//
//  Created by Руслан Жигалов on 23.06.2023.
//

import Foundation
struct MonsterProfileCache {
    static let key = "monsterProfileCache"
    static func save(_ value: [monsterModel]!) {
         UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: key)
    }
    static func get() -> [monsterModel]! {
        var userData: [monsterModel] = []
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            userData = try! PropertyListDecoder().decode([monsterModel].self, from: data)
            return userData
        } else {
            return userData
        }
    }
    static func remove() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
