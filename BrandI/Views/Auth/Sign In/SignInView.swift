//
//  SignUp.swift
//  Challange1
//
//  Created by Gehad Eid on 01/10/2024.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject private var vm = SignInViewModel()
    @State private var isPasswordVisible: Bool = false
    @Binding var isAuthenticated: Bool

    var body: some View {
        VStack(spacing: 10) {
            Text("Sign in")
                .font(.title)
                .fontWeight(.bold)
            
            VStack(alignment: .leading,spacing: 14){
                
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
                
                
                if let passwordError = vm.passwordError {
                    Text(passwordError)
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            
            // Sign Up Button
            Button(action: {
                Task {
                    try await vm.signIn() {
                        isAuthenticated = true
                    }
                }
            }) {
                Text("Sign in")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("BabyBlue"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            // Divider with "Or"
            orDivider(text: "Sign In With")
        }
        .padding(.bottom,8)
        .padding(.top,30)
        .padding(.horizontal,20)
    }
}

#Preview {
    SignInView(isAuthenticated: .constant(false))
}
