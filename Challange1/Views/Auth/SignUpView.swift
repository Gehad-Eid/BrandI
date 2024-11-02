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
    @State private var isAgree: Bool = false
    
    var body: some View {
         
        VStack(spacing: 16) {
            Text("Sign up")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, -30)
            
            VStack(alignment: .leading,spacing: 14){
                
                Text("Full Name")
                    .font(.caption)
                    .foregroundColor(.black)
                
                CustomTextField(placeholder: "", text: $vm.name)
                
                
                Text("Email")
                    .font(.caption)
                    .foregroundColor(.black)
                
                CustomTextField(placeholder: "", text: $vm.email)
                
                Text("Example@email.com")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                
                Text("Password")
                    .font(.caption)
                    .foregroundColor(.black)
                
                CustomSecureField(placeholder: "", text: $vm.password, isPasswordVisible: $isPasswordVisible)
                
                Text("Must be 8 characters")
                    .font(.caption)
                    .foregroundColor(.gray)
                
            }
            HStack {
                Button(action: {
                    isAgree.toggle()
                }) {
                    Image(systemName: isAgree ? "checkmark.square" : "square")
                        .foregroundColor(.gray)
                        .cornerRadius(8)
                }
                Text("I agree with terms and conditions and privacy policy")
                    .font(.caption)
            }
            
            // Sign Up Button
            Button(action: {
                Task {
                    do {
                        try await vm.signUp()
                        isAuthenticated = true
                    } catch {
                        print("Error: \(error)")
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
            
            // Divider with "Or Sign in with"
            HStack {
                Text("")
                
                Text("Or Sign in with")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text("")
            }
            .padding(.vertical)
        }
        .padding(.vertical,8)
        .padding(.horizontal,20)
    }
}


#Preview {
    SignUpView(isAuthenticated: .constant(false))
}
