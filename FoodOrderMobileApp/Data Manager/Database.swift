//
//  Database.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 09.11.23.
//

import Foundation
import RealmSwift
//

class Database {
    var realm: Realm {
        do {
            return try Realm()
        } catch {
            fatalError("Error initializing Realm: \(error)")
        }
    }

    // MARK: - CRUD Operations

    func saveToDB(user: User) {
        do {
            try realm.write {
                realm.add(user, update: .modified)
            }
        } catch {
            print("Error saving to DB: \(error)")
        }
    }

    func fetchFromDB() -> [User] {
        do {
            let objects = realm.objects(User.self)
            return Array(objects)
        } catch {
            print("Error fetching from DB: \(error)")
            return []
        }
    }

    func getUser(email: String) -> User? {
        return realm.objects(User.self).filter("email == %@", email).first
    }

    // MARK: - Utility Functions

    func getFilePath() {
        if let url = realm.configuration.fileURL {
            print("Realm file path: \(url)")
        }
    }
}
