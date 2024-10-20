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

    var body: some View {
        VStack {
            Text("Sign Up")
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

            SecureField("Confirm Password", text: $vm.confirmPassword)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                // Action to handle sign-up
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
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()

//            Spacer()
        }
        .padding()
    }
}

#Preview {
    SignUpView(isAuthenticated: .constant(false))
}
