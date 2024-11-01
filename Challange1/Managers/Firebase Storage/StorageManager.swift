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
    
    private func userReference(userId: String) -> StorageReference {
        storage.child("users").child(userId)
    }
    
    private func userPostReference(userId: String, postId: String) -> StorageReference {
        storage.child("users").child(userId).child(postId)
    }
    
    func saveImage(data: Data, name: String, userId: String, postId: String) async throws -> (path: String, name: String) {
        let meta = StorageMetadata()
        
        meta.contentType = "image/jpeg"
        let path = "\(name).jpeg"
//        let returnedMetaData = try await userReference(userId: userId).child(path).putDataAsync(data, metadata: meta)
        let returnedMetaData = try await userPostReference(userId: userId, postId: postId).child(path).putDataAsync(data, metadata: meta)
        
        guard let returnedPath = returnedMetaData.path, let returnedName = returnedMetaData.name else {
            throw URLError(.badServerResponse)
        }
        
        return (returnedPath, returnedName)
    }
    
    func getImage(userId: String, postId: String, path: String) async throws -> UIImage {
        //let data = try await userReference(userId: userId).child(path).data(maxSize: 3 * 1024 * 1024)
//        let data = try await userPostReference(userId: userId, postId: postId).child(path).data(maxSize: 3 * 1024 * 1024)
        let data = try await storage.child(path).data(maxSize: 10 * 1024 * 1024)
        
        guard let image = UIImage(data: data) else {
            throw URLError(.badServerResponse)
        }
        
        return image
    }
    
    func getUrlForImage(path: String) async throws -> URL {
        try await Storage.storage().reference(withPath: path).downloadURL()
    }
    
    
}
