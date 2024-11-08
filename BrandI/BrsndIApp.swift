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
    @StateObject private var addPostViewModel = AddPostViewModel()
    @StateObject private var agendaViewModel = AgendaViewModel()

   
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var vm = AgendaViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mainViewModel)
                .environmentObject(addPostViewModel)
                .environmentObject(agendaViewModel)
                .onAppear{
                    Task {
                        if let userID = UserDefaults.standard.string(forKey: "userID") {
                            try await vm.loadPosts(userId: userID)
                            try await vm.loadEvents(userId: userID)
                            
                            try await vm.loadMonthPostsAndEvents(userId: userID)
                            
                            try await vm.loadRecentPosts(userId: userID)
                            
                            vm.loadDraftPosts()
                            vm.loadUpcomingPostsAndEvents()
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

