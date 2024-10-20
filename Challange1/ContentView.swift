//
//  ContentView.swift
//  Challange1
//
//  Created by Gehad Eid on 29/09/2024.
//

import SwiftUI

struct ContentView: View {
    @State var isFirstTimeUser: Bool = false
    @State var isAuthenticated: Bool = false
    @State var doneSplash: Bool = false
    
    var body: some View {
        
        if isFirstTimeUser {
            OnboardingView(isFirstTimeUser: $isFirstTimeUser)
        }
        else if isAuthenticated, doneSplash {
            MainTabView(isAuthenticated: $isAuthenticated)
        }
        else if !isAuthenticated, doneSplash {
            AuthContainerView(isAuthenticated: $isAuthenticated)
        }
        else {
            Splash(isFirstTimeUser: $isFirstTimeUser, isAuthenticated: $isAuthenticated, doneSplash: $doneSplash)
        }
    }
//    //    @State var main = false
//    //    @State var authenticated = false
//    //    @State var onboarding = false
//    //
//    
//    //    @State private var isFirstTimeUser = false
//    //    @State private var isAuthenticated = false
//    
//    @State private var hasCompletedOnboarding = true
//    @State private var isAuthenticated = false
//    
//    var body: some View {
//        //        if main {
//        //            MainTabView(isAuthenticated: $main)
//        //        } else if authenticated {
//        //            AuthContainerView(isAuthenticated: $main)
//        //        } else if onboarding {
//        //            OnboardingView(isOnboardingCompleted: $authenticated)
//        //        } else {
//        //            Splash(isSplashComplete: $onboarding, showSignInView: $authenticated)
//        //        }
//        if !hasCompletedOnboarding {
//            if hasCompletedOnboarding {
//                // Check authentication
//                if isAuthenticated {
//                    if !isAuthenticated {
//                        // Navigate to sign in
//                        AuthContainerView()
//                    } else {
//                        // Navigate to the main page
//                        MainTabView()
//                    }
//                }
//            } else {
//                // Navigate to onboarding
//                OnboardingView(isOnboardingCompleted: $hasCompletedOnboarding)
//            }
//        } else {
//            // Show splash while checking
//            Splash()
//                .onAppear(perform: checkUserStatus)
//        }
//    }
//    
//    private func checkUserStatus() {
//        // Check if it's the first time user
//        let hasCompletedOnboarding = !UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
//        self.hasCompletedOnboarding = hasCompletedOnboarding
//        
//        var authUser: AuthDataResultModel? = nil
//        
//        if !hasCompletedOnboarding {
//            // Check if the user is authenticated
//            authUser = try? FirebaseAuthManager.shared.getAuthenticatedUser()
//            print("authUser: \(authUser?.email ?? "nil")")
//            print(hasCompletedOnboarding)
//            //            showSignInView = authUser == nil
//        } else {
//            print(" here completed \(hasCompletedOnboarding)")
//        }
//        
//        if authUser != nil {
//            self.isAuthenticated = true
//        } else {
//            self.isAuthenticated = false
//        }
//    }
//    
}

#Preview {
    ContentView()
}
