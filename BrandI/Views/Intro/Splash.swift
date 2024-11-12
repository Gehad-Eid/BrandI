//
//  Splash.swift
//  Challange1
//
//  Created by Gehad Eid on 29/09/2024.
//

import SwiftUI
import SDWebImageSwiftUI
struct Splash: View {
    
    @Binding var isFirstTimeUser: Bool
    @Binding var isAuthenticated: Bool
    @Binding var doneSplash: Bool
    
    @State private var isVisible = false
    
    var body: some View {
        VStack {
            //TODO: add app icon
            SpriteKitAnimationView()
             
        }.ignoresSafeArea()
     
        .onAppear {
            // Trigger the animation when the view appears
            withAnimation {
                isVisible = true
            }
            
            checkUserStatus()
        }
    }
    
    private func checkUserStatus() {
        // Check if it's the first time user
        let isFirstTimeUser = !UserDefaults.standard.bool(forKey: "isFirstTimeUser")
        print(isFirstTimeUser)
        
        if !isFirstTimeUser {
            // Check if the user is authenticated
            if let authUser = try? FirebaseAuthManager.shared.getAuthenticatedUser() {
                print("authUser: \(authUser.email ?? "nil")")
                self.isAuthenticated = true
            } else {
                print("yay")
                self.isAuthenticated = false
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            // After the animation is done, set isFirstTimeUser
            self.doneSplash = true
            self.isFirstTimeUser = isFirstTimeUser
        }
    }
}
// A parent view for preview purposes
struct SplashPreviewWrapper: View {
    @State private var isFirstTimeUser = false
    @State private var isAuthenticated = false
    @State private var doneSplash = false
    
    var body: some View {
        Splash(isFirstTimeUser: $isFirstTimeUser, isAuthenticated: $isAuthenticated, doneSplash: $doneSplash)
    }
}

#Preview {
    SplashPreviewWrapper()
}
