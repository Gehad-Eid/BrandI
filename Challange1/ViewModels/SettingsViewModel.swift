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
    
    func signOut(onSuccess: @escaping () -> Void) throws {
        do {
            try FirebaseAuthManager.shared.signOut()
            onSuccess()
        } catch {
            print("Error signing out: \(error)")
        }
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
    
    func validatePassword(email: String, password: String) async throws -> Bool {
        do {
            let authResult = try await FirebaseAuthManager.shared.signIn(email: email, password: password)
            
            // Return true if sign-in is successful
            return authResult != nil
        } catch let error as NSError {
            print("Error signing in: \(error.localizedDescription)")
            throw error // Re-throw the error to handle it in the calling function
        }
    }
    
}


