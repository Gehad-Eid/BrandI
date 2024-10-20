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
    
    var body: some View {
        TabView {
            AgendaView()
                .tabItem {
                    Label("Agenda", systemImage: "house.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
            
            // for fast accsess , u can delete 'em ---
            SettingsView(isAuthenticated: $isAuthenticated)
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
            
            EvaluatePostView()
                .tabItem {
                    Label("Evaluate Post", systemImage: "pencil")
                }
            // --------------
        }
    }
}


#Preview {
    MainTabView(isAuthenticated: .constant(false))
}
