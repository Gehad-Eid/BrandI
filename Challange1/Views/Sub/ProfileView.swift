//
//  ProfileView.swift
//  Challange1
//
//  Created by Gehad Eid on 10/10/2024.
//


import SwiftUI

struct ProfileView: View {
    @StateObject private var vm = MainViewModel()
    
    var body: some View {
        List {
            if let user = vm.user {
                Text("User \(user.email)")
                Text("User \(user.userId)")
                Text("User \(user.name)")
                Text("User \(user.dateCreated)")
            }
        }
        .task {
            try? await vm.loadCurrentUser()
        }
        .navigationTitle("Profile")
    }
}

#Preview {
    ProfileView()
}
