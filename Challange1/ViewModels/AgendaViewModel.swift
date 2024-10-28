//
//  AgendaViewModel.swift
//  Challange1
//
//  Created by Gehad Eid on 21/10/2024.
//

import Foundation

@MainActor
final class AgendaViewModel: ObservableObject {
    
    @Published private(set) var posts: [Post]? = nil
    @Published private(set) var events: [Event]? = nil
    @Published private(set) var draftPosts: [Post]? = nil
    
    func loadPosts(userId: String) async throws {
        self.posts = try await UserManager.shared.getUserPosts(userID: userId)
    }
    
    func loadgAllPostsSortedByDate(userId: String) async throws {
        self.posts = try await UserManager.shared.getAllPostsSortedByDate(userID: userId, descending: true, referenceDate: Date())
    }
    
    func loadEvents(userId: String) async throws {
        self.events = try await UserManager.shared.getUserEvents(userID: userId)
    }
    
    func loadDraftPosts() {
        guard let posts = posts else { return }
        draftPosts = posts.filter { $0.isDraft == true }
    }
    
    func loadPostById(userId: String, postId: String) async throws -> Post? {
        return try await UserManager.shared.getPost(userID: userId, postId: postId)
    }
    
    
}
