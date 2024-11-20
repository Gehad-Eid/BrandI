//
//  ContentView.swift
//  Challange1
//
//  Created by Gehad Eid on 29/09/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var networkMonitor = NetworkMonitor()
    
    @State private var isCheckingConnection = false
    @State var isFirstTimeUser: Bool = false
    @State var isAuthenticated: Bool = false
    @State var doneSplash: Bool = false
    
    var body: some View {
        if !networkMonitor.isConnectedToWiFi {
            NoWiFiView(onRetry: checkWiFiConnection)
                .overlay(
                    isCheckingConnection ? ProgressView().padding() : nil
                )
        }
        else if isFirstTimeUser {
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
    
    private func checkWiFiConnection() {
        isCheckingConnection = true
        networkMonitor.checkWiFiConnection {
            DispatchQueue.main.async {
                isCheckingConnection = false
            }
        }
    }
}

#Preview {
    ContentView()
}
