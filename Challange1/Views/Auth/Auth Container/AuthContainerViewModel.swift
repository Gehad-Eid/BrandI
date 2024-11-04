//
//  authContainerViewModel.swift
//  Challange1
//
//  Created by Gehad Eid on 18/10/2024.
//

import Foundation
import FirebaseAuth

@MainActor
final class AuthContainerViewModel: ObservableObject {
    @Published var errorMessage: String?
    
    func signInWithGoogle(onSuccess: @escaping () -> Void) async throws {
        let helper = SignInWithGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await FirebaseAuthManager.shared.signInWithGoogle(tokens: tokens)
        let user = DBUser(authUser: authDataResult)
        
        do {
            try await UserManager.shared.createNewUser(user: user)

            // Call the onSuccess callback on successful sign-up
            onSuccess()
        } catch let error as NSError {
            print(error)
            handleSignInSSOError(error)
        }
    }
    
    func signInWithApple(onSuccess: @escaping () -> Void) async throws {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let authDataResult = try await FirebaseAuthManager.shared.signInWithApple(tokens: tokens)
        let user = DBUser(authUser: authDataResult)
        
        do {
            try await UserManager.shared.createNewUser(user: user)

            // Call the onSuccess callback on successful sign-up
            onSuccess()
        } catch let error as NSError {
            print(error)
            handleSignInSSOError(error)
        }
    }
    
    private func handleSignInSSOError(_ error: NSError) {
        switch AuthErrorCode(rawValue: error.code) {
        case .invalidEmail:
            errorMessage = "The email address is invalid."
        case .userDisabled:
            errorMessage = "This account has been disabled."
        case .wrongPassword:
            errorMessage = "The password you entered is incorrect."
        case .userNotFound:
            errorMessage = "No account found with this email address."
        case .invalidCredential:
            errorMessage = "The credential provided is invalid. Please try signing in again."
        case .accountExistsWithDifferentCredential:
            errorMessage = "An account already exists with a different sign-in method. Try signing in using the linked method."
        case .credentialAlreadyInUse:
            errorMessage = "This credential is already linked to another account."
        case .operationNotAllowed:
            errorMessage = "Sign-in with this provider is not allowed. Please contact support."
        case .providerAlreadyLinked:
            errorMessage = "This provider is already linked to your account."
        case .appNotAuthorized:
            errorMessage = "This app is not authorized to use Firebase Authentication with the provided API key."
        case .networkError:
            errorMessage = "A network error occurred. Please check your connection and try again."
        case .requiresRecentLogin:
            errorMessage = "Please re-authenticate and try again."
        case .userTokenExpired:
            errorMessage = "Your session has expired. Please sign in again."
        case .webContextAlreadyPresented:
            errorMessage = "A web sign-in context is already open. Please close any open windows and try again."
        case .webContextCancelled:
            errorMessage = "Sign-in was cancelled. Please try again."
        case .invalidAPIKey:
            errorMessage = "The API key is invalid. Please check your app configuration."
        case .appVerificationUserInteractionFailure:
            errorMessage = "App verification failed. Please try again."
        case .missingClientIdentifier:
            errorMessage = "The client identifier is missing. Please contact support."
        case .missingOrInvalidNonce:
            errorMessage = "An invalid nonce was provided. Please try signing in again."
        case .adminRestrictedOperation:
            errorMessage = "This operation is restricted by the administrator."
        case .internalError:
            errorMessage = "An internal error occurred. Please try again later."
        case .secondFactorRequired:
            errorMessage = "A second factor is required for sign-in. Please complete the additional verification."
        case .secondFactorAlreadyEnrolled:
            errorMessage = "The second factor is already enrolled."
        case .unsupportedFirstFactor:
            errorMessage = "This sign-in method does not support first factor authentication."
        default:
            errorMessage = "An unexpected error occurred. Please try again."
        }
    }

}
