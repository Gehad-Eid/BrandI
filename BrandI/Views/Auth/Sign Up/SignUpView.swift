//
//  SignUp.swift
//  Challange1
//
//  Created by Gehad Eid on 01/10/2024.
//

import SwiftUI


struct SignUpView: View {
    @StateObject private var vm = SignUpViewModel()
    @Binding var isAuthenticated: Bool
    
    @State private var isPasswordVisible: Bool = false
    @State private var isConfirmPasswordVisible: Bool = false
    @State private var isAgree: Bool = false
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Sign up")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("Text"))
            
            VStack(alignment: .leading, spacing: 14) {
                // Name Field
                Text("Full Name")
                    .font(.caption)
                    .foregroundColor(Color("Text"))
                
                CustomTextField(placeholder: "", text: $vm.name, showError: $vm.nameError)
                
                if let nameError = vm.nameError {
                    Text(nameError)
                        .font(.caption)
                        .foregroundColor(.red)
                }
                
                // Email Field
                Text("Email")
                    .font(.caption)
                    .foregroundColor(Color("Text"))
                
                CustomTextField(placeholder: "", text: $vm.email, showError: $vm.emailError)
                
                if let emailError = vm.emailError {
                    Text(emailError)
                        .font(.caption)
                        .foregroundColor(.red)
                }
                
                // Password Field
                Text("Password")
                    .font(.caption)
                    .foregroundColor(Color("Text"))
                
                CustomSecureField(placeholder: "", text: $vm.password, isPasswordVisible: $isPasswordVisible, showError: $vm.passwordError)
                    .onChange(of: vm.password) { _ in
                        vm.validatePassword()
                    }
                
                if let passwordError = vm.passwordError {
                    Text(passwordError)
                        .font(.caption)
                        .foregroundColor(.red)
                }
                
                // Password Requirements List
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Image(systemName: vm.hasMinLength ? "checkmark.square" : "xmark.app")
                            .foregroundColor(vm.hasMinLength ? .green : (vm.showError ? .red : .gray))
                        
                        Text("Must be at least 8 characters")
                            .foregroundColor(vm.hasMinLength ? .green : (vm.showError ? .red : .gray))
                            .font(.caption)
                    }
                    
                    HStack {
                        Image(systemName: vm.hasUppercase ? "checkmark.square" : "xmark.app")
                            .foregroundColor(vm.hasMinLength ? .green : (vm.showError ? .red : .gray))
                        
                        Text("Must contain an uppercase letter")
                            .foregroundColor(vm.hasUppercase ? .green : (vm.showError ? .red : .gray))
                            .font(.caption)
                    }
                    
                    HStack {
                        Image(systemName: vm.hasLowercase ? "checkmark.square" : "xmark.app")
                            .foregroundColor(vm.hasMinLength ? .green : (vm.showError ? .red : .gray))
                        
                        Text("Must contain a lowercase letter")
                            .foregroundColor(vm.hasLowercase ? .green : (vm.showError ? .red : .gray))
                            .font(.caption)
                    }
                    
                    HStack {
                        Image(systemName: vm.hasNumber ? "checkmark.square" : "xmark.app")
                            .foregroundColor(vm.hasNumber ? .green : (vm.showError ? .red : .gray))
                        
                        Text("Must contain a number")
                            .foregroundColor(vm.hasNumber ? .green : (vm.showError ? .red : .gray))
                            .font(.caption)
                    }
                }
                .padding(.horizontal)
                
                // Confirm Password Field
                Text("Confirm Password")
                    .font(.caption)
                    .foregroundColor(Color("Text"))
                
                CustomSecureField(placeholder: "", text: $vm.confirmPassword, isPasswordVisible: $isConfirmPasswordVisible, showError: $vm.confirmPasswordError)
                
                if let confirmPasswordError = vm.confirmPasswordError {
                    Text(confirmPasswordError)
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            
            // Terms and Conditions
            HStack {
                Button(action: { vm.isAgree.toggle() }) {
                    Image(systemName: vm.isAgree ? "checkmark.square" : "square")
                        .foregroundColor(.gray)
                        .cornerRadius(8)
                }
                
                Text("I agree with terms and conditions and privacy policy")
                    .font(.caption)
                    .foregroundColor(vm.isAgree || !vm.showError ? .gray : .red)
            }
            
            // Sign Up Button
            Button(action: {
                Task {
                    try await vm.signUp() {
                        // A callback function
                        isAuthenticated = true
                    }
                }
            }) {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("BabyBlue"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            // Divider with "Or"
            orDivider(text: "Sign Up With")
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 20)
    }
}


#Preview {
    SignUpView(isAuthenticated: .constant(false))
}
