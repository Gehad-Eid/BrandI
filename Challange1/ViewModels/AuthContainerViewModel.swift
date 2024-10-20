//
//  authContainerViewModel.swift
//  Challange1
//
//  Created by Gehad Eid on 18/10/2024.
//

import Foundation

@MainActor
final class AuthContainerViewModel: ObservableObject {
    func signInWithGoogle() async throws {
        let helper = SignInWithGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await FirebaseAuthManager.shared.signInWithGoogle(tokens: tokens)
        let user = DBUser(authUser: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
    
    func signInWithApple() async throws {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let authDataResult = try await FirebaseAuthManager.shared.signInWithApple(tokens: tokens)
//        try await UserManager.shared.createNewUser(auth: authDataResult)
        let user = DBUser(authUser: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
}
