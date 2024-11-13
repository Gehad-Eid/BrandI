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
//    @StateObject private var addPostViewModel = AddPostViewModel()
    @StateObject private var agendaViewModel = AgendaViewModel()

   
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mainViewModel)
//                .environmentObject(addPostViewModel)
                .environmentObject(agendaViewModel)
                .onAppear{
                    Task {
                        if let userID = UserDefaults.standard.string(forKey: "userID") {
                            try await agendaViewModel.loadPosts(userId: userID)
                            try await agendaViewModel.loadEvents(userId: userID)
                            
                            try await agendaViewModel.loadMonthPostsAndEvents(userId: userID)
                            
                            try await agendaViewModel.loadRecentPosts(userId: userID)
                            
                            agendaViewModel.loadDraftPosts()
                            agendaViewModel.loadUpcomingPostsAndEvents()
                        } else {
                            print("userID not found")
                        }
                    }
                }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

