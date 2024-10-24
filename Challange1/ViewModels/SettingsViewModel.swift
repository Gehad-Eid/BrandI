//
//  SettingsViewModel.swift
//  Challange1
//
//  Created by Gehad Eid on 10/10/2024.
//

import SwiftUI

@MainActor
final class SettingsViewModel : ObservableObject {
    @Published var authProviders: [AuthProviderOption] = []
    
    func loadAuthProviders() {
        if let providers = try? FirebaseAuthManager.shared.getProviders() {
            authProviders = providers
        }
    }
    
    func signOut() throws {
        try FirebaseAuthManager.shared.signOut()
    }
    
    func deleteAccount() async throws {
        let authUser = try FirebaseAuthManager.shared.getAuthenticatedUser()
        try await UserManager.shared.deleteUser(userID:authUser.uid)
        try await FirebaseAuthManager.shared.delete()
    }
    
    func resetPassword() async throws {
        let authUser = try FirebaseAuthManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        
        try await FirebaseAuthManager.shared.resetPassword(email: email)
    }
    
    func updateEmail(email: String) async throws {
        let authUser = try FirebaseAuthManager.shared.getAuthenticatedUser()
        
//        guard let email = authUser.email else {
//            throw URLError(.fileDoesNotExist)
//        }
        
//        let email = "gg@gg.com"
        
        try await FirebaseAuthManager.shared.updateEmail(email: email)
    }
    
    func updatePassword(pass: String) async throws {
        let authUser = try FirebaseAuthManager.shared.getAuthenticatedUser()
        
//        guard let password = authUser.email else {
//            throw URLError(.fileDoesNotExist)
//        }
//       let password = "123456789"
        
        try await FirebaseAuthManager.shared.updatePassword(password: pass)
    }
    
}


