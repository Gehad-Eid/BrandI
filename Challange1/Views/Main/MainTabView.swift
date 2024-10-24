//
//  MainTabView.swift
//  Challange1
//
//  Created by Gehad Eid on 29/09/2024.
//

import SwiftUI

//TODO: make the app load from DB in the splash

struct MainTabView: View {
    @Binding var isAuthenticated: Bool
    @StateObject private var vm = MainViewModel()
    
    var body: some View {
        TabView {
            AgendaView()
                .tabItem {
                    Label("Agenda", systemImage: "house.fill")
                }
            
            //SettingsView(isAuthenticated: $isAuthenticated)
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
            
            
            // for fast accsess , u can delete 'em ---
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
            
            EvaluatePostView()
                .tabItem {
                    Label("Evaluate Post", systemImage: "pencil")
                }
            // --------------
        }
        .task {
            try? await vm.loadCurrentUser()
        }
    }
}


#Preview {
    MainTabView(isAuthenticated: .constant(false))
}
