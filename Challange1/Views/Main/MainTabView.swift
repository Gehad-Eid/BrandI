//
//  MainTabView.swift
//  Challange1
//
//  Created by Gehad Eid on 29/09/2024.
//

import SwiftUI

//TODO: make the app load from DB in the splash
import SwiftUI

struct MainTabView: View {
    @Binding var isAuthenticated: Bool
    @StateObject private var vm = MainViewModel()
    @State private var selectedTab = 0 // Track the selected tab

    var body: some View {
        TabView(selection: $selectedTab) {
            AgendaView()
                .tabItem {
                    Label("Agenda", systemImage: "house.fill")
                }
                .tag(0)
            
            CalenderMainView()
                .tabItem {
                    Label("Calendar", image: "Calendar_icon")
                }
                .tag(1)
            
            SettingsView(isAuthenticated: $isAuthenticated)
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(2)
        }
        .accentColor(.babyBlue)
        .task {
            try? await vm.loadCurrentUser()
        }
    }
}

#Preview {
    MainTabView(isAuthenticated: .constant(false))
}
