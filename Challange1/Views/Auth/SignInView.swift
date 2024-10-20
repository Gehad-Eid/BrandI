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
    @Binding var isAuthenticated: Bool

    var body: some View {
        VStack {
            Text("Sign In")
                .font(.largeTitle)
                .padding()

            TextField("Email", text: $vm.email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Password", text: $vm.password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())


            Button(action: {
                // Action to handle sign-up
                Task {
                    do {
                        try await vm.signIn()
                        isAuthenticated = true
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }) {
                Text("Sign In")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
            Button(action: {
                // Action to handle sign-up
                Task {
                    do {
                        try await vm.signIn()
                        isAuthenticated = true
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }) {
                Text("Google In")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow)
                    .cornerRadius(10)
            }
            .padding()

//            Spacer()
        }
        .padding()
    }
}

#Preview {
    SignInView(isAuthenticated: .constant(false))
}
