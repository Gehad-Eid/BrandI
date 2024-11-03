//
//  SignInViewModel.swift
//  Challange1
//
//  Created by Gehad Eid on 03/11/2024.
//

import Foundation
import FirebaseAuth

@MainActor
final class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    @Published var emailError: String?
    @Published var passwordError: String?
    
    var isValidEmail: Bool {
        // Regular expression for basic email validation
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func validateFields() -> Bool {
        var isValid = true
        
        // Email Validation
        if email.isEmpty {
            emailError = "Email is required."
            isValid = false
        } else if !isValidEmail {
            emailError = "Enter a valid email address."
            isValid = false
        } else {
            emailError = nil
        }
        
        // Password Validation
        if password.isEmpty {
            passwordError = "Password is required."
            isValid = false
        } else {
            passwordError = nil
        }
        
        return isValid
    }
    
    func signIn(onSuccess: @escaping () -> Void) async throws {
        guard validateFields() else { return }
        
        do {
            try await FirebaseAuthManager.shared.signIn(email: email, password: password)
            
            // Call the onSuccess callback on successful sign-up
            onSuccess()
        } catch let error as NSError {
            print(error)
            handleSignInError(error)
        }
    }
    
    private func handleSignInError(_ error: NSError) {
        switch AuthErrorCode(rawValue: error.code) {
        case .invalidEmail:
            emailError = "The email address is invalid."
        case .userDisabled:
            emailError = "This account has been disabled."
        case .wrongPassword:
            emailError = ""
            passwordError = "Incorrect email or/and password."
        case .userNotFound, .invalidCredential:
            emailError = "No account found with this email address. Please sign Up "
            passwordError = ""
        default:
            emailError = ""
            passwordError = "An unexpected error occurred. Please try again."
        }
    }
}
