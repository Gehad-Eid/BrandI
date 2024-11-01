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
    
    @Published var title: String = ""
    @Published var postContent: String = ""
    @Published var selectedDate = Date()
    @Published var selectedPlatforms: [Platform] = []
    @Published var isDraft: Bool = false
//    @Published var imageList: [UIImage] = []
    @Published var imageList: [(image: UIImage, name: String)] = []
    @Published var imageDataList: [ImageData] = []
    
    @Published var startDate = Date()
    @Published var endDate = Date()
    
    @Published var postId = ""
    @Published var eventId = ""
    
    @Published var newDocInfo: (docId: String, doc: DocumentReference)?
    @Published var uploadedImages: [ImageData] = []
//    @Published var uploadedImagesURLs: [String] = []
    
    
    
    //Save image to firestore storage
    func saveImagesToFirebase() async throws {
        var uploadedImages: [ImageData] = []
//        var uploadedURLs: [String] = []
        
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
//                        uploadedURLs.append(url.absoluteString)
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
//        self.uploadedImagesURLs = uploadedURLs
    }
        
    // Add New Post
    func addPost(userId: String) {
        Task {
            // Save images in DB and save their URLs
            try await saveImagesToFirebase()
            
//            var imagePaths: [String] {
//                uploadedImagePaths.map { $0.path }
//            }
            
            guard let newDocInfo = newDocInfo else {
                print("Error: newDocInfo is nil")
                return
            }
            
            let post = Post(postId: newDocInfo.docId,
                            title: title,
                            content: postContent,
                            date: selectedDate,
                            images: uploadedImages,
//                            imagesPaths: imagePaths,
                            platforms: selectedPlatforms,
                            isDraft: isDraft
            )
            
            postId = try await UserManager.shared.addNewPost(userID: userId, post: post, docInfo: newDocInfo)
            print("postId in vm: \(postId)")
            
        }
    }
    
    // Update a post
    func updatePost(userId: String, postId: String) {
        Task {
            // Save images
            try await saveImagesToFirebase()
            
//            var imagesPaths: [String] {
//                uploadedImagePaths.map { $0.name }
//            }
            
            let updatedPost = Post(
                postId: postId,
                title: title,
                content: postContent,
                date: selectedDate,
                images: uploadedImages,
//                imagesPaths: imagesPaths,
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
    
    // Get the images from URL to UIImage
    private var inProgressImageURLs = Set<String>()

    func getImageToUIImage(userId: String, images: [ImageData]) async throws {
        var tempImageList: [(image: UIImage, name: String)] = []
        
        for imageData in images {
            // Skip if this URL is already being downloaded
            if inProgressImageURLs.contains(imageData.imageUrl) { continue }
            
            // Mark the URL as in progress
            inProgressImageURLs.insert(imageData.imageUrl)
            
            // Download the image asynchronously
            do {
                if let image = try await downloadImage(userId: userId, imagePath: imageData, postId: postId) {
                    tempImageList.append((image, imageData.name))
                }
            } catch {
                print("Error downloading image: \(error)")
            }
            
            // Remove from in progress set after download completes
            inProgressImageURLs.remove(imageData.imageUrl)
        }
        
        self.imageList = tempImageList
    }

    // Helper function to download an image
    private func downloadImage(userId: String, imagePath: ImageData, postId: String) async throws -> UIImage? {
        try await StorageManager.shared.getImage(userId: userId, postId: postId, path: imagePath.path)
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

//    func getImageToUIImage(userId: String, images: [ImageData]) async throws {
//        var tempImageList: [(image: UIImage, name: String)] = []
//
//        for imageData in images {
//            if let imageURL = URL(string: imageData.imageUrl) {
//                let image = try await StorageManager.shared.getImage(userId: userId, postId: postId, path: imageData.name)
//                tempImageList.append((image: image, name: imageData.name))
//            }
//        }
//        self.imageList = tempImageList
//    }
//    func getImageToUIImage(userId: String, images: [ImageData]) async throws {
////        if imageList
////        if let imageURL = URL(string: path) {
////
////            let imageData = try await StorageManager.shared.getImage(userId: "", postId: "", path: "")
////        }
//        var tempImageList: [(image: UIImage, name: String)] = []
//
//    }
