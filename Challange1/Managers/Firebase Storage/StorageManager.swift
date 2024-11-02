//
//  StorageManager.swift
//  Challange1
//
//  Created by Gehad Eid on 30/10/2024.
//

import Foundation
import FirebaseStorage
import UIKit

final class StorageManager {
    static let shared = StorageManager()
    init() {}
    
    private let storage = Storage.storage().reference()
    
    // The user reference in Firebase Storage
    private func userReference(userId: String) -> StorageReference {
        storage.child("users").child(userId)
    }
    
    // The post reference in Firebase Storage
    private func userPostReference(userId: String, postId: String) -> StorageReference {
        storage.child("users").child(userId).child(postId)
    }
    
    // The image path reference
    func getPathForImage(path: String) -> StorageReference {
        Storage.storage().reference(withPath: path)
    }
    
    // Get the URL for an image
    func getUrlForImage(path: String) async throws -> URL {
        try await getPathForImage(path: path).downloadURL()
    }
    
    // Save images to DB
    func saveImage(data: Data, name: String, userId: String, postId: String) async throws -> (path: String, name: String) {
        let meta = StorageMetadata()
        
        meta.contentType = "image/jpeg"
        let path = "\(name).jpeg"
        let returnedMetaData = try await userPostReference(userId: userId, postId: postId).child(path).putDataAsync(data, metadata: meta)
        
        guard let returnedPath = returnedMetaData.path, let returnedName = returnedMetaData.name else {
            throw URLError(.badServerResponse)
        }
        
        return (returnedPath, returnedName)
    }
    
    // Get an UIImage from URL
    func getImage(userId: String, postId: String, path: String) async throws -> UIImage {
        let data = try await storage.child(path).data(maxSize: 10 * 1024 * 1024)
        
        guard let image = UIImage(data: data) else {
            throw URLError(.badServerResponse)
        }
        
        return image
    }
    
    // Delete a spicific image
    func deleteImage(path: String) async throws {
        try await getPathForImage(path:path).delete()
    }
    
    // Delete all images for a post
    func deleteImages(userId: String, postId: String) async throws {
        do {
            print("start image")
            //            try await userPostReference(userId: userId, postId: postId).delete()
            
            let postFolderRef = userPostReference(userId: userId, postId: postId)
            
            // List all items in the post folder
            let allItems = try await postFolderRef.listAll()
            
            // Iterate over each item and delete it
            for item in allItems.items {
                try await item.delete()
            }
            
            print("end image")
            
        } catch {
            print(error)
        }
    }
    
}
