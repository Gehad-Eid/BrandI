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
    @StateObject private var calenerviewModel = CalenderViewModel()
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            AgendaView(calenerviewModel: calenerviewModel, mainTabSelection: $selectedTab)
                .tabItem {
                    Label("Agenda", systemImage: "house.fill")
                }
                .tag(0)
            
            CalenderMainView(calenerviewModel: calenerviewModel)
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
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
