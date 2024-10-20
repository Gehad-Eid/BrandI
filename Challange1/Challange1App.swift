//
//  Challange1App.swift
//  Challange1
//
//  Created by Gehad Eid on 29/09/2024.
//

import SwiftUI
import FirebaseCore

@main
struct Challange1App: App {
    
    //    init() {
    //        FirebaseApp.configure()
    //        print ("Configured Firebase!")
    //    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

