//
//  SettingsView.swift
//  Challange1
//
//  Created by Gehad Eid on 01/10/2024.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var vm = SettingsViewModel()
    @Binding var isAuthenticated: Bool
    
    var body: some View {
        List {
            Button("log out"){
                Task {
                    do {
                        try vm.signOut()
                        isAuthenticated = false
                    } catch {
                        print("Error signing out: \(error)")
                    }
                }
            }
            
            Button(role: .destructive) {
                Task {
                    do {
                        try await vm.deleteAccount()
                        isAuthenticated = false
                    }
                    catch {
                        print (error)
                    }
                }
            } label: {
                Text ("Delete account")
            }
            
            if vm.authProviders.contains(.email){
                Button("reset password"){
                    Task {
                        do {
                            try await vm.resetPassword()
                            isAuthenticated = false
                        } catch {
                            print("Error signing out: \(error)")
                        }
                    }
                }
                
                Button("update password"){
                    Task {
                        do {
                            try await vm.updatePassword()
                            isAuthenticated = false
                        } catch {
                            print("Error signing out: \(error)")
                        }
                    }
                }
                
                Button("update email"){
                    Task {
                        do {
                            try await vm.updateEmail()
                            isAuthenticated = false
                        } catch {
                            print("Error signing out: \(error)")
                        }
                    }
                }
            }
        }
        .onAppear{
            vm.loadAuthProviders()
        }
    }
}

#Preview {
    SettingsView(isAuthenticated: .constant(false))
}
