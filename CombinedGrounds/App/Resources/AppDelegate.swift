//
//  AppDelegate.swift
//  CombinedGrounds
//
//  Created by Kenny Dubroff on 12/9/21.
//

import UIKit
import Firebase


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static let shared = AppDelegate()
    
    let networkManager = NetworkManager()

    // instantiate after FirebaseApp.configure
    var databaseManager: DatabaseManager!

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        databaseManager = DatabaseManager()

        return true
    }
}
