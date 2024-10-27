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
    
    func addPost(userId: String) {
        let post = Post(postId: "", title: postTitle, content: postContent, date: selectedDate, platforms: selectedPlatforms, isDraft: isDraft)
        Task {
            try await UserManager.shared.addNewPost(userID: userId, post: post)
        }
    }
    
    func addEvent(userId: String) {
        let event = Event(eventId: "", title: postTitle, content: postContent, startDate: selectedDate, endDate: selectedDate)
        Task {
            try await UserManager.shared.addNewevent(userID: userId, event: event)
        }
    }
}
