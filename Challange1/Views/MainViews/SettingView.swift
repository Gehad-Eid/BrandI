//
//  SettingView.swift
//  Challange1
//
//  Created by sumaiya on 21/10/2567 BE.
//

import SwiftUI
import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                settingsRow(iconName: "envelope", title: "Email")
                settingsRow(iconName: "key.fill", title: "Password")
              
                settingsRow(iconName: "link", title: "Integration")
                settingsRow(iconName: "touchid", title: "My Identity")
                settingsRow(iconName: "arrowshape.turn.up.left", title: "Sign Out")
            }
            .scrollContentBackground(.hidden)
            .background(Color.background)
            .navigationTitle("Settings")
        }
    }



    // Reusable Row for Settings Items
    @ViewBuilder
    private func settingsRow(iconName: String, title: String) -> some View {
        NavigationLink(destination: Text("\(title) Screen")) {
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(.babyBlue)
                Text(title)
                    .font(.system(size: 18, weight: .medium))
                    .padding(.leading, 10)
                Spacer()
               
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 18)
                            .fill(Color.white))
        }
    }
}

#Preview {
    SettingsView()
}
