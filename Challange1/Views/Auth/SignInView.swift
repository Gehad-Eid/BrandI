//
//  SignUp.swift
//  Challange1
//
//  Created by Gehad Eid on 01/10/2024.
//

import SwiftUI

@MainActor
final class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        try await FirebaseAuthManager.shared.signIn(email: email, password: password)
    }
}

struct SignInView: View {
    
    @StateObject private var vm = SignInViewModel()
    @State private var isPasswordVisible: Bool = false
    @Binding var isAuthenticated: Bool

    var body: some View {
        VStack(spacing: 16) {
            Text("Sign in")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, -30)
            VStack(alignment: .leading,spacing: 14){
                
                Text("Email")
                    .font(.caption)
                    .foregroundColor(.black)
                CustomTextField(placeholder: "", text: $vm.email)
                Text("Example@gmail.com")
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
            
            // Sign Up Button
            Button(action: {
                Task {
                    do {
                        try await vm.signIn()
                        isAuthenticated = true
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }) {
                Text("Log in")
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
            
            // Apple and Gmail Sign In Buttons
//            HStack(spacing: 16) {
//                CustomSocialButton(icon: "Apple" )
//                CustomSocialButton(icon: "Google")
//            }
//            HStack {
//                Text("Don’t have an account? ")
//                    .foregroundColor(.gray)
//                
//                Button(action: {
//                    // Log in action here
//                }) {
//                    Text("Sign up")
//                        .foregroundColor(Color("BabyBlue"))
//                    
//                }
//            }.padding(.top,10)
        }
        .padding(.vertical,8)
        .padding(.horizontal,20)
    }
//    var body: some View {
//        VStack {
//            Text("Sign In")
//                .font(.largeTitle)
//                .padding()
//
//            TextField("Email", text: $vm.email)
//                .keyboardType(.emailAddress)
//                .autocapitalization(.none)
//                .padding()
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//
//            SecureField("Password", text: $vm.password)
//                .padding()
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//
//
//            Button(action: {
//                // Action to handle sign-up
//                Task {
//                    do {
//                        try await vm.signIn()
//                        isAuthenticated = true
//                    } catch {
//                        print("Error: \(error)")
//                    }
//                }
//            }) {
//                Text("Sign In")
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//            .padding()
//            
//            Button(action: {
//                // Action to handle sign-up
//                Task {
//                    do {
//                        try await vm.signIn()
//                        isAuthenticated = true
//                    } catch {
//                        print("Error: \(error)")
//                    }
//                }
//            }) {
//                Text("Google In")
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.yellow)
//                    .cornerRadius(10)
//            }
//            .padding()
//
////            Spacer()
//        }
//        .padding()
//    }
}

#Preview {
    SignInView(isAuthenticated: .constant(false))
}
