//
//  StorageManager.swift
//  Challange1
//
//  Created by Gehad Eid on 30/10/2024.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
    init() {}
    
    private let storage = Storage.storage().reference()
    
    private func userReference (userId: String) -> StorageReference {
        storage.child( "users").child(userId)
    }
    
    func saveImage(data: Data, userId: String) async throws -> (path: String, name: String) {
        let meta = StorageMetadata()
        
        meta.contentType = "image/jpeg"
        let path = "\(UUID().uuidString).jpeg"
        let returnedMetaData = try await userReference(userId: userId).child(path).putDataAsync(data, metadata: meta)
        
        guard let returnedPath = returnedMetaData.path, let returnedName = returnedMetaData.name else {
            throw URLError(.badServerResponse)
        }
        
        return (returnedPath, returnedName)
    }
    
    func getData(userId: String, path: String) async throws -> Data {
        try await userReference(userId: userId).child(path).data(maxSize: 3 * 1024 * 1024)
    }
}
