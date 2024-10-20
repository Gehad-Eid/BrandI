//
//  UserManager.swift
//  Challange1
//
//  Created by Gehad Eid on 18/10/2024.
//


import Foundation
import FirebaseFirestore

final class UserManager {
    static let shared = UserManager()
    private  init(){}
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private let encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
    
    private let decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    private func postCollection(userId: String) -> CollectionReference {
        userCollection.document(userId).collection("posts")
    }
    
    private func postDocument(userId: String, postId: String) -> DocumentReference {
        postCollection(userId: userId).document(postId)
    }
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false)
    }
    
    func getUser(userID: String) async throws -> DBUser {
        try await userDocument(userId: userID).getDocument(as: DBUser.self)
    }
    
    func addNewPost(userID: String, post: Post) async throws {
        try userDocument(userId: userID).collection("posts").document().setData(from: post, merge: false)
    }
    
    func deletePost(userID: String, postID: String) async throws {
        try await userDocument(userId: userID).collection("posts").document(postID).delete()
    }
    
//    func createNewUser(auth: AuthDataResultModel) async throws {
//        var userData: [String:Any] = [
//        "user_id" : auth.uid,
//        "date_created" : Timestamp(),
//        ]
//        
//        if let email = auth.email {
//            userData ["email"] = email
//        }
//        
//        try await userDocument(userId: auth.uid).setData(userData, merge: false)
//    }
    
//    func getUser(userID: String) async throws -> DBUser {
//        let snapshot = try await userDocument(userId: userID).getDocument()
//        
//        guard let data = snapshot.data() , let userID = data["user_id"] as? String else {
//            throw URLError(.badServerResponse)
//        }
//        
//        let email = data["email"] as? String
//        let dateCreated = data["date_created"] as? Date
//                    
//        return DBUser(userID: userID, email: email, dateCreated: dateCreated)
//    }
}
