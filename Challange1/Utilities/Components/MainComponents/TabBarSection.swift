//
//  TabBarSection.swift
//  Challange1
//
//  Created by sumaiya on 21/10/2567 BE.
//

import SwiftUI

import SwiftUI

struct TabBarSection: View {
    
    @State var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MainView()
                .tabItem {
                    Image("Agenda_1")
                    Text("Agenda")
                }
                .tag(0)
            
            EventView()
                .tabItem {
                    Image("Calendar_icon")
                    Text("My Calendar")
                }
                .tag(1)
            
           // SettingsView()
                .tabItem {
                    Image("Settings_icon")
                    Text("Settings")
                }
                .tag(2)
        }
        .accentColor(Color("BabyBlue")) // Set accent color for the selected tab
    }
}

#Preview {
    TabBarSection()
}
