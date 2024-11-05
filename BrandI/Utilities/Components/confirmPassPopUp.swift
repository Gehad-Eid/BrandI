//
//  confirmPassPopUps.swift
//  Challange1
//
//  Created by Gehad Eid on 26/10/2024.
//

import SwiftUI

struct confirmPassPopUp: View {
    
    @Binding var showDeleteAlert: Bool
    @Binding var isAuthenticated: Bool
    
    @State private var passwordInput: String = ""
    @State private var showErrorMessage = false
    @State private var errorMessage = ""
    
    @ObservedObject var vm: SettingsViewModel
    @StateObject var authVM = AuthContainerViewModel()
    
    
    var body: some View {
        Color.black.opacity(0.4)
            .edgesIgnoringSafeArea(.all)
        
        VStack(spacing: 20) {
            Text(vm.authProviders.contains(.email) ? "Enter your password to confirm deletion." : "Confirm deletion.")
                .font(.headline)
                .padding()
            
            if vm.authProviders.contains(.email) {
                SecureField("Password", text: $passwordInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            
            // Error message for incorrect password
            if showErrorMessage {
                //                Text("Incorrect password.")
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.horizontal)
            }
            
            HStack {
                Button("Cancel") {
                    showDeleteAlert = false
                    passwordInput = ""  // Clear the password input
                    showErrorMessage = false  // Reset error message
                }
                .padding(.horizontal)
                .buttonStyle(DefaultButtonStyle())
                .foregroundColor(.blue)
                
                Spacer()
                
                Button("Delete Account") {
                    // Validate the password before deleting
                    if vm.authProviders.contains(.email) {
                        Task {
                            if try await vm.validatePassword(email: FirebaseAuthManager.shared.getAuthenticatedUser().email ?? "", password: passwordInput) {
                                try await vm.deleteAccount()
                                isAuthenticated = false
                            } else {
                                showErrorMessage = true  // Show error message if password is incorrect
                                errorMessage = "Incorrect password."
                            }
                        }
                    }
                    else if vm.authProviders.contains(.google) {
                        Task {
                            do {
                                try vm.signOut(){}
                                
                                try await authVM.signInWithGoogle(){
                                    Task {
                                        try await vm.deleteAccount()
                                        isAuthenticated = false
                                    }
                                }
                            } catch {
                                showErrorMessage = true
                                errorMessage = error.localizedDescription
                            }
                        }
                    }
                    else if vm.authProviders.contains(.apple) {
                        Task {
                            do {
                                try vm.signOut(){}
                                try await authVM.signInWithApple(){
                                    Task {
                                        try await vm.deleteAccount()
                                        isAuthenticated = false
                                    }
                                }
                            } catch {
                                showErrorMessage = true
                                errorMessage = error.localizedDescription
                            }
                        }
                    }
                    
                }
                .buttonStyle(DefaultButtonStyle())
                .padding(.horizontal)
                .foregroundColor(.red)
            }
            .padding()
        }
        .frame(width: 300)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 20)
        .padding()
        .onAppear(){
            vm.loadAuthProviders()
        }
    }
}

#Preview {
    confirmPassPopUp(showDeleteAlert: .constant(false), isAuthenticated: .constant(true), vm: SettingsViewModel())
}
