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
    
    func loadPosts(userId: String) async throws {
        self.posts = try await UserManager.shared.getUserPosts(userID: userId)
    }
    
    func loadEvents(userId: String) async throws {
        self.events = try await UserManager.shared.getUserEvents(userID: userId)
    }
    
    func loadPostById(userId: String, postId: String) async throws -> Post? {
        
//        self.events = try await UserManager.shared.getUserEvents(userID: userId)
        
        return Post(postId: "test", title: "test", content: "test", date: Date())
    }
    
    
}
