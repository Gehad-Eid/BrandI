//
//  AddPostViewModel.swift
//  Challange1
//
//  Created by Gehad Eid on 21/10/2024.
//

import Foundation
import UIKit

@MainActor
final class AddPostViewModel: ObservableObject {
    
    @Published var postTitle: String = ""
    @Published var postContent: String = ""
    @Published var selectedDate = Date()
    @Published var selectedPlatforms: [Platform] = []
    @Published var isDraft: Bool = false
    @Published var imageList: [UIImage] = []
    
    @Published var startDate = Date()
    @Published var endDate = Date()
    
    @Published var postId = ""
    
    // Add New Post
    func addPost(userId: String) {
        let post = Post(postId: "", title: postTitle, content: postContent, date: selectedDate, platforms: selectedPlatforms, isDraft: isDraft)
        Task {
            postId = try await UserManager.shared.addNewPost(userID: userId, post: post)
            print("postId in vm: \(postId)")
        }
    }
    
    // Update a post
    func updatePost(userId: String, postId: String) {
        let updatedPost = Post(
            postId: postId,
            title: postTitle,
            content: postContent,
            date: selectedDate,
            platforms: selectedPlatforms,
            isDraft: isDraft
        )
        
        Task {
            do {
                try await UserManager.shared.updatePost(userID: userId, post: updatedPost)
            } catch {
                // Handle error (e.g., show an alert)
                print("Failed to update post: \(error)")
            }
        }
    }
    
    // Add New Event
    func addEvent(userId: String) {
        let event = Event(eventId: "", title: postTitle, startDate: startDate, endDate: endDate)
        Task {
            try await UserManager.shared.addNewevent(userID: userId, event: event)
        }
    }
}
