//
//  SignUpViewModel.swift
//  Challange1
//
//  Created by Gehad Eid on 19/10/2024.
//

import Foundation
import FirebaseAuth
import SwiftUICore

@MainActor
final class SignUpViewModel: ObservableObject {
    @Published var email = ""
    @Published var name = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published var isAgree = false
    
    @Published var emailError: String?
    @Published var nameError: String?
    @Published var passwordError: String?
    @Published var confirmPasswordError: String?
    
    // Validation flags for password requirements
    @Published var hasMinLength = false
    @Published var hasUppercase = false
    @Published var hasLowercase = false
    @Published var hasNumber = false
    
    @Published var showError = false
//    @Published var errorMessage = ""

    
    var isValidEmail: Bool {
        // Regular expression for basic email validation
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func validatePassword() {
        hasMinLength = password.count >= 8
        hasUppercase = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        hasLowercase = password.rangeOfCharacter(from: .lowercaseLetters) != nil
        hasNumber = password.rangeOfCharacter(from: .decimalDigits) != nil
    }
    
    func validateFields() -> Bool {
        var isValid = true
        
        // Name Validation
        if name.isEmpty {
            nameError = "Name is required."
            isValid = false
        } else {
            nameError = nil
        }
        
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
        
        // Confirm Password Validation
        if confirmPassword.isEmpty {
            passwordError = "Confirm Password is required."
        } else if confirmPassword != password {
            confirmPasswordError = "Passwords do not match."
            isValid = false
        } else {
            confirmPasswordError = nil
        }
        
        return isValid
    }
    
    func signUp(onSuccess: @escaping () -> Void) async throws {
        guard validateFields(), hasMinLength, hasUppercase, hasLowercase, hasNumber, isAgree else {
            showError = true
            return
        }
        
        do {
            let authDataResult = try await FirebaseAuthManager.shared.createUser(email: email, password: password)
            let user = DBUser(authUser: authDataResult)
            try await UserManager.shared.createNewUser(user: user)
            
            // Call the onSuccess callback on successful sign-up
            onSuccess()
            
        } catch let error as NSError {
            handleSignUpError(error)  // Call function to handle specific error codes
        }
    }
    
    private func handleSignUpError(_ error: NSError) {
        switch AuthErrorCode(rawValue: error.code) {
        case .invalidEmail:
            emailError = "The email address is invalid. Please enter a valid email."
        case .emailAlreadyInUse:
            emailError = "The email address is already in use. Please use a different email or try signing in."
        case .weakPassword:
            passwordError = "The password is too weak. Please choose a stronger password."
        default:
            confirmPasswordError = "An unexpected error occurred. Please try again."
        }
        showError = true
    }
}
