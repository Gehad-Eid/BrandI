//
//  Challange1App.swift
//  Challange1
//
//  Created by Gehad Eid on 29/09/2024.
//

import SwiftUI
import FirebaseCore

@main
struct BrandIApp: App {
    @StateObject private var mainViewModel = MainViewModel()
    @StateObject private var calenerviewModel = CalenderViewModel()
    @StateObject private var agendaViewModel = AgendaViewModel()
    
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mainViewModel)
                .environmentObject(calenerviewModel)
                .environmentObject(agendaViewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

