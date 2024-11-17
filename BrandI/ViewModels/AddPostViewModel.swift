//
//  AddPostViewModel.swift
//  Challange1
//
//  Created by Gehad Eid on 21/10/2024.
//

import Foundation
import UIKit
import FirebaseFirestore

@MainActor
final class AddPostViewModel: ObservableObject {
    
    var isPostFormValid: Bool {
        !title.isEmpty && !postContent.isEmpty && selectedPlatforms.isEmpty == false
    }
    
    var isEventFormValid: Bool {
        !title.isEmpty && startDate <= endDate
    }

    @Published var title: String = ""
    @Published var postContent: String = ""
    @Published var selectedDate = Date()
    @Published var selectedPlatforms: [Platform] = []
    @Published var isDraft: Bool = false
    @Published var imageList: [(image: UIImage, name: String)] = []
    @Published var imageDataList: [ImageData] = []
    
    @Published var startDate = Date()
    @Published var endDate = Date()
    
    @Published var postId = ""
    @Published var eventId = ""
    
    @Published var newDocInfo: (docId: String, doc: DocumentReference)?
    @Published var uploadedImages: [ImageData] = []
    
    @Published var updateUITrigger: Bool = false
    
    private var inProgressImageURLs = Set<String>()
    
    func reset() {
        title = ""
        postContent = ""
        selectedDate = Date()
        selectedPlatforms = []
        isDraft = false
        imageList = []
        imageDataList = []
        startDate = Date()
        endDate = Date()
    }
    
    //Save image to firestore storage
    func saveImagesToFirebase() async throws {
        var uploadedImages: [ImageData] = []
        
        if let userID = UserDefaults.standard.string(forKey: "userID") {
            // Creat a doc in firestore and save it's ID and doc refrance
            let docInfo = UserManager.shared.createPostIdAndDocument(userID: userID)
            
            for (image, filename) in imageList {
                if let data = image.jpegData(compressionQuality: 1){
                    do {
                        let imageInfo = try await StorageManager.shared.saveImage(data: data, name: filename, userId: userID, postId: docInfo.docId)
                        
                        let url = try await StorageManager.shared.getUrlForImage(path: imageInfo.path)
                        
                        let imageDataInfo = ImageData(imageUrl: url.absoluteString, path: imageInfo.path, name: imageInfo.name)
                        
                        uploadedImages.append(imageDataInfo)
                    } catch {
                        print("Error uploading image: \(error.localizedDescription)")
                    }
                } else {
                    print("Error converting UIImage to Data")
                }
            }
            
            self.newDocInfo = docInfo
        }
        self.uploadedImages = uploadedImages
    }
        
    // Add New Post
    func addPost(userId: String, onSuccess: @escaping () -> Void) {
        Task {
            // Save images in DB and save their URLs
            try await saveImagesToFirebase()
            
            guard let newDocInfo = newDocInfo else {
                print("Error: newDocInfo is nil")
                return
            }
            
            let post = Post(postId: newDocInfo.docId,
                            title: title,
                            content: postContent,
                            date: selectedDate,
                            images: uploadedImages,
                            platforms: selectedPlatforms,
                            isDraft: isDraft
            )
            
            postId = try await UserManager.shared.addNewPost(userID: userId, post: post, docInfo: newDocInfo)
            print("postId in vm: \(postId)")
            
            onSuccess()
        }
    }
    
    func deletePost(userId: String, postId: String) async throws {
        try await StorageManager.shared.deleteImages(userId: userId, postId: postId)
        try await UserManager.shared.deletePost(userID: userId, postID: postId)
        updateUITrigger.toggle()
    }
    
    // Update a post
    func updatePost(userId: String, postId: String, onSuccess: @escaping () -> Void) {
        Task {
            // Save images
            try await saveImagesToFirebase()
            
            let updatedPost = Post(
                postId: postId,
                title: title,
                content: postContent,
                date: selectedDate,
                images: uploadedImages,
                platforms: selectedPlatforms,
                isDraft: isDraft
            )
            
            do {
                try await UserManager.shared.updatePost(userID: userId, post: updatedPost)
            } catch {
                // TODO: Handle error
                print("Failed to update post: \(error)")
            }
            
            updateUITrigger.toggle()
            onSuccess()
        }
    }
    
    // Get the images from URL to UIImage
    func getImageToUIImage(userId: String, images: [ImageData]) async throws {
        var tempImageList: [(image: UIImage, name: String)] = []
        let maxConcurrentTasks = 4 // Limit concurrent downloads

        // Dictionary to track active downloads
        var activeTasks: [String: Task<(UIImage, String)?, Error>] = [:]

        // TaskGroup with limited concurrent downloads
        try await withThrowingTaskGroup(of: (UIImage, String)?.self, body: { group in
            for imageData in images {
                // Access and modify inProgressImageURLs on the main actor
                let alreadyInProgress = await MainActor.run {
                    if inProgressImageURLs.contains(imageData.imageUrl) {
                        return true
                    }
                    inProgressImageURLs.insert(imageData.imageUrl)
                    return false
                }

                if alreadyInProgress {
                    print("Skipping already in-progress URL: \(imageData.imageUrl)")
                    continue
                }

                // Check if the URL is already being processed
                if let existingTask = activeTasks[imageData.imageUrl] {
                    group.addTask {
                        return try await existingTask.value
                    }
                    continue
                }

                // Add a new download task
                let task = Task<(UIImage, String)?, Error> {
                    do {
                        if let image = try await self.downloadImage(userId: userId, imagePath: imageData, postId: self.postId) {
                            return (image, imageData.name)
                        } else {
                            return nil
                        }
                    } catch {
                        print("Error downloading image \(imageData.imageUrl): \(error)")
                        return nil
                    }
                }

                activeTasks[imageData.imageUrl] = task
                group.addTask {
                    let result = try await task.value
                    await MainActor.run {
                        self.inProgressImageURLs.remove(imageData.imageUrl) // Remove from progress tracking
                    }
                    return result
                }
            }

            // Collect results
            for try await result in group {
                if let validResult = result {
                    tempImageList.append(validResult)
                }
            }
        })

        // Update the image list
        await MainActor.run {
            self.imageList = tempImageList
        }
    }



//    func getImageToUIImage(userId: String, images: [ImageData]) async throws {
//        var tempImageList: [(image: UIImage, name: String)] = []
//
//        for imageData in images {
//            // Skip if this URL is already being downloaded
//            if inProgressImageURLs.contains(imageData.imageUrl) { continue }
//
//            // Mark the URL as in progress
//            inProgressImageURLs.insert(imageData.imageUrl)
//
//            // Download the image asynchronously
//            do {
//                if let image = try await downloadImage(userId: userId, imagePath: imageData, postId: postId) {
//                    tempImageList.append((image, imageData.name))
//                }
//            } catch {
//                print("Error downloading image: \(error)")
//            }
//
//            // Remove from in progress set after download completes
//            inProgressImageURLs.remove(imageData.imageUrl)
//        }
//
//        self.imageList = tempImageList
//    }

    // Helper function to download an image
    private func downloadImage(userId: String, imagePath: ImageData, postId: String) async throws -> UIImage? {
        try await StorageManager.shared.getImage(userId: userId, postId: postId, path: imagePath.path)
    }
    
    // Add New Event
    func addEvent(userId: String, onSuccess: @escaping () -> Void) {
        let event = Event(eventId: "", title: title, startDate: startDate, endDate: endDate)
        Task {
           eventId = try await UserManager.shared.addNewevent(userID: userId, event: event)
            print("eventId in vm: \(eventId)")
            onSuccess()
        }
    }
    
    func deleteEvent(userId: String, eventId: String) async throws {
        try await UserManager.shared.deleteEvent(userID: userId, eventID: eventId)
        updateUITrigger.toggle()
    }
    
    // Update a event
    func updateEvent(userId: String, eventId: String, onSuccess: @escaping () -> Void) {
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
            
            updateUITrigger.toggle()
            onSuccess()
        }
    }
}
