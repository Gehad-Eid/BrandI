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
        else if /*isAuthenticated,*/ doneSplash {
            MainTabView(isAuthenticated: $isAuthenticated)
        }
//        else if !isAuthenticated, doneSplash {
////            AuthContainerView(isAuthenticated: $isAuthenticated)
//            AuthContainerView(isAuthenticated: $isAuthenticated)
//        }
        else {
            Splash(isFirstTimeUser: $isFirstTimeUser, isAuthenticated: $isAuthenticated, doneSplash: $doneSplash)
        }
    }
}

#Preview {
    ContentView()
}
