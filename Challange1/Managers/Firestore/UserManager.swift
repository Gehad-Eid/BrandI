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
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false)
    }
    
    func getUser(userID: String) async throws -> DBUser {
        try await userDocument(userId: userID).getDocument(as: DBUser.self)
    }
    
    func deleteUser(userID: String) async throws {
        try await userDocument(userId: userID).delete()
    }
    
    func updateEmail(userID: String, newEmail: String) async throws {
        try await userDocument(userId: userID).updateData([DBUser.CodingKeys.email.rawValue: newEmail])
    }
}

// MARK: Posts functions
extension UserManager {
    private func postCollection(userId: String) -> CollectionReference {
        userCollection.document(userId).collection("posts")
    }
    
    private func postDocument(userId: String, postId: String) -> DocumentReference {
        postCollection(userId: userId).document(postId)
    }
    
    func addNewPost(userID: String, post: Post) async throws {
        let document = postCollection(userId: userID).document()
        let docId = document.documentID
        
        // Convert platforms to their raw string values
        let platformStrings = post.platforms?.map { $0.rawValue }
        
        let data: [String:Any] = [
            Post.CodingKeys.postId.rawValue : docId,
            Post.CodingKeys.date.rawValue : post.date,
            Post.CodingKeys.title.rawValue : post.title,
            Post.CodingKeys.content.rawValue : post.content,
            Post.CodingKeys.images.rawValue: post.images,
            Post.CodingKeys.platforms.rawValue: platformStrings,
            Post.CodingKeys.recommendation.rawValue: post.recommendation,
            Post.CodingKeys.isDraft.rawValue: post.isDraft
        ]
        
        try await document.setData(data, merge: false)
    }
    
    func deletePost(userID: String, postID: String) async throws {
        try await postCollection(userId: userID).document(postID).delete()
    }
    
    func getUserPosts(userID: String) async throws -> [Post] {
        let snapshot = try await postCollection(userId: userID).getDocuments()
        
        let posts = try snapshot.documents.compactMap { document in
            try document.data(as: Post.self)
        }
        return posts
    }
    
    func updatePostStatus (userID: String, post: Post) async throws {
        try postDocument(userId: userID, postId: post.postId).setData(from: post, merge: true, encoder: encoder())
    }
    
    func getAllPostsSortedByDate(userID: String, descending: Bool, referenceDate: Date) async throws -> [Post] {
        let calendar = Calendar.current
        let startOfYesterday = calendar.startOfDay(for: calendar.date(byAdding: .day, value: -1, to: referenceDate)!)
        let endOfTomorrow = calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: referenceDate))!

        let snapshot = try await postCollection(userId: userID)
            .whereField(Post.CodingKeys.isDraft.rawValue, isEqualTo: false)
            .whereField(Post.CodingKeys.date.rawValue, isGreaterThanOrEqualTo: startOfYesterday)
            .whereField(Post.CodingKeys.date.rawValue, isLessThanOrEqualTo: endOfTomorrow)
            .order(by: Post.CodingKeys.date.rawValue, descending: descending)
            .getDocuments()

        let posts = try snapshot.documents.compactMap { document in
            try document.data(as: Post.self)
        }

        return posts
    }
    
    func getPost(userID: String, postId: String) async throws -> Post? {
        return try await postDocument(userId: userID, postId: postId).getDocument().data(as: Post.self)
    }

    
    func getAllDraftPostsSortedBydate(userID: String) async throws -> [Post] {
        let snapshot = try await postCollection(userId: userID)
            .whereField(Post.CodingKeys.isDraft.rawValue, isEqualTo: true)
            .order(by: Post.CodingKeys.date.rawValue, descending: true)
            .getDocuments()
        
        let posts = try snapshot.documents.compactMap { document in
            try document.data(as: Post.self)
        }
        
        return posts
    }
}

// MARK: events functions
extension UserManager {
    
    private func eventCollection(userId: String) -> CollectionReference {
        userCollection.document(userId).collection("events")
    }
    
    private func eventDocument(userId: String, eventId: String) -> DocumentReference {
        eventCollection(userId: userId).document(eventId)
    }
    
    func addNewevent(userID: String, event: Event) async throws {
        let document = eventCollection(userId: userID).document()
        let docId = document.documentID
        
        let data: [String:Any] = [
            Event.CodingKeys.eventId.rawValue: docId,
            Event.CodingKeys.title.rawValue: event.title,
            Event.CodingKeys.content.rawValue: event.content,
            Event.CodingKeys.startDate.rawValue: event.startDate,
            Event.CodingKeys.endDate.rawValue: event.endDate
        ]
        
        try await document.setData(data, merge: false)
    }
    
    func deleteEvent(userID: String, eventID: String) async throws {
        try await eventCollection(userId: userID).document(eventID).delete()
    }
    
    func getUserEvents(userID: String) async throws -> [Event] {
        let snapshot = try await eventCollection(userId: userID).getDocuments()
        
        let events = try snapshot.documents.compactMap { document in
            try document.data(as: Event.self)
        }
        
        return events
    }
}
