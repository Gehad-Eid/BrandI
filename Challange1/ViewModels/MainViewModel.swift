//
//  ProfileViewModel.swift
//  Challange1
//
//  Created by Gehad Eid on 19/10/2024.
//

import Foundation

@MainActor
final class MainViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let userDataResult = try FirebaseAuthManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userID: userDataResult.uid)
    }
    
//    func deleteCurrentUser() async throws {
//        let userDataResult = try FirebaseAuthManager.shared.getAuthenticatedUser()
//        try FirebaseAuthManager.shared.signOut()
//        try await UserManager.shared.deleteUser(userID: userDataResult.uid)
//        self.user = nil
//    }
}
