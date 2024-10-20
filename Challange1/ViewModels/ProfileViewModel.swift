//
//  ProfileViewModel.swift
//  Challange1
//
//  Created by Gehad Eid on 19/10/2024.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let userDataResult = try FirebaseAuthManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userID: userDataResult.uid)
    }
}
