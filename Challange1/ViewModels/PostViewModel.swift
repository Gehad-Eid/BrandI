//
//  PostViewModel.swift
//  Challange1
//
//  Created by Gehad Eid on 19/10/2024.
//


import Foundation

@MainActor
final class PostViewModel: ObservableObject {
    
    @Published private(set) var post: Post? = nil

    func updatePost(userId: String, post: Post) {
//        guard let userId, let post else { return }
//        let currentValue = post.isDraft ?? false
        
        let updatedPost = post.toggleIsDraft()
        
        Task {
            try await UserManager.shared.updatePostStatus(userID: userId, post: updatedPost)
        }
    }
    
}
