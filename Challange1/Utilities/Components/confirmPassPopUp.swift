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
    
    @ObservedObject var vm: SettingsViewModel
    
    
    var body: some View {
        Color.black.opacity(0.4)
            .edgesIgnoringSafeArea(.all)
        
        VStack(spacing: 20) {
            Text("Enter your password to confirm deletion.")
                .font(.headline)
                .padding()
            
            SecureField("Password", text: $passwordInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Error message for incorrect password
            if showErrorMessage {
                Text("Incorrect password.")
                    .foregroundColor(.red)
//                    .padding(.top, 5)
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
                    Task {
                        do {
                            // Validate the password before deleting
                            if try await vm.validatePassword(email: FirebaseAuthManager.shared.getAuthenticatedUser().email ?? "", password: passwordInput) {
                                
                                try await vm.deleteAccount()
                                isAuthenticated = false
                            } else {
                                showErrorMessage = true  // Show error message if password is incorrect
                            }
                        } catch {
                            print("Failed to delete account: \(error.localizedDescription)")
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
    }
}

#Preview {
    confirmPassPopUp(showDeleteAlert: .constant(false), isAuthenticated: .constant(true), vm: SettingsViewModel())
}
