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
    
    @Published var title: String = ""
    @Published var postContent: String = ""
    @Published var selectedDate = Date()
    @Published var selectedPlatforms: [Platform] = []
    @Published var isDraft: Bool = false
    @Published var imageList: [UIImage] = []
    
    @Published var startDate = Date()
    @Published var endDate = Date()
    
    @Published var postId = ""
    @Published var eventId = ""
    
    @Published var uploadedImagePaths: [(path: String, name: String)] = []
    
    //Save image to firestore storage
    func saveImagesToFirebase() async throws {
        var uploadedImages: [(path: String, name: String)] = []
        
        for image in imageList {
            if let data = image.jpegData(compressionQuality: 0.8), let userID = UserDefaults.standard.string(forKey: "userID") {
                do {
                    let imageInfo = try await StorageManager.shared.saveImage(data: data, userId: userID)
                    uploadedImages.append(imageInfo)
                } catch {
                    print("Error uploading image: \(error.localizedDescription)")
                }
            } else {
                print("Error converting UIImage to Data")
            }
        }
        self.uploadedImagePaths = uploadedImages
    }
    
    //
    
    // Add New Post
    func addPost(userId: String) {
        Task {
            try await saveImagesToFirebase()
            
            var imageNames: [String] {
                uploadedImagePaths.map { $0.name }
            }
            
            let post = Post(postId: "", title: title, content: postContent, date: selectedDate, images: imageNames, platforms: selectedPlatforms, isDraft: isDraft)
            
            postId = try await UserManager.shared.addNewPost(userID: userId, post: post)
            print("postId in vm: \(postId)")
        }
    }
    
    // Update a post
    func updatePost(userId: String, postId: String) {
        Task {
            try await saveImagesToFirebase()
            
            var imageNames: [String] {
                uploadedImagePaths.map { $0.name }
            }
            
            let updatedPost = Post(
                postId: postId,
                title: title,
                content: postContent,
                date: selectedDate,
                images: imageNames,
                platforms: selectedPlatforms,
                isDraft: isDraft
            )
            
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
        let event = Event(eventId: "", title: title, startDate: startDate, endDate: endDate)
        Task {
           eventId = try await UserManager.shared.addNewevent(userID: userId, event: event)
            print("eventId in vm: \(eventId)")
        }
    }
    
    // Update a event
    func updateEvent(userId: String, eventId: String) {
        let updatedEvent = Event(
            eventId: eventId,
            title: title,
            startDate: startDate,
            endDate: endDate
        )
        
        Task {
            do {
                try await UserManager.shared.updateEvent(userID: userId, event: updatedEvent)
            } catch {
                // Handle error (e.g., show an alert)
                print("Failed to update event: \(error)")
            }
        }
    }
}
