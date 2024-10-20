//
//  SignUpViewModel.swift
//  Challange1
//
//  Created by Gehad Eid on 19/10/2024.
//

import Foundation

@MainActor
final class SignUpViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        let authDataResult = try await FirebaseAuthManager.shared.createUser(email: email, password: password)
//        try await UserManager.shared.createNewUser(auth: authDataResult)
        let user = DBUser(authUser: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
}
