//
//  DatabaseManager.swift
//  CombinedGrounds
//
//  Created by Kenny Dubroff on 12/9/21.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class DatabaseManager {
    let db = Database.database().reference()

    func getValue<T: Codable>(at endpoint: String, type: T.Type, completion: @escaping (Result<T?, Error>) -> Void) {
        db.child(endpoint).getData { error, snapshot in
            do {
                let data = try snapshot.data(as: T.self)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
