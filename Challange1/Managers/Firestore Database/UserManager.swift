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
    
    func addNewPost(userID: String, post: Post) async throws -> String{
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
        
        return docId
    }
//        func addNewPost(userID: String, post: Post) async throws {
//        var docId: String
//        
//        if post.postId.isEmpty {
//            let document = postCollection(userId: userID).document()
//            docId = document.documentID
//        } else {
//            docId = post.postId
//        }
//        // Convert platforms to their raw string values
//        let platformStrings = post.platforms?.map { $0.rawValue }
//        
//        let data: [String:Any] = [
//            Post.CodingKeys.postId.rawValue : docId,
//            Post.CodingKeys.date.rawValue : post.date,
//            Post.CodingKeys.title.rawValue : post.title,
//            Post.CodingKeys.content.rawValue : post.content,
//            Post.CodingKeys.images.rawValue: post.images,
//            Post.CodingKeys.platforms.rawValue: platformStrings,
//            Post.CodingKeys.recommendation.rawValue: post.recommendation,
//            Post.CodingKeys.isDraft.rawValue: post.isDraft
//        ]
//        
//        try await document.setData(data, merge: false)
//    }
    
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
    
    func getPost(userID: String, postId: String) async throws -> Post? {
        return try await postDocument(userId: userID, postId: postId).getDocument().data(as: Post.self)
    }
    
    func updatePost(userID: String, post: Post) async throws {
        try postDocument(userId: userID, postId: post.postId).setData(from: post, merge: true, encoder: encoder())
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
    
    func addNewevent(userID: String, event: Event) async throws -> String{
        let document = eventCollection(userId: userID).document()
        let docId = document.documentID
        
        let data: [String:Any] = [
            Event.CodingKeys.eventId.rawValue: docId,
            Event.CodingKeys.title.rawValue: event.title,
            Event.CodingKeys.startDate.rawValue: event.startDate,
            Event.CodingKeys.endDate.rawValue: event.endDate
        ]
        
        try await document.setData(data, merge: false)
        return docId
    }
    
    func deleteEvent(userID: String, eventID: String) async throws {
        try await eventCollection(userId: userID).document(eventID).delete()
    }
    
    func updateEvent(userID: String, event: Event) async throws {
        try eventDocument(userId: userID, eventId: event.eventId).setData(from: event, merge: true, encoder: encoder())
    }
    
    func getUserEvents(userID: String) async throws -> [Event] {
        let snapshot = try await eventCollection(userId: userID).getDocuments()
        
        let events = try snapshot.documents.compactMap { document in
            try document.data(as: Event.self)
        }
        
        return events
    }
}

//MARK: Complex Queries
extension UserManager {
    //get Recent Posts for the cards in the agenda view
    func getRecentPosts(userID: String, descending: Bool, referenceDate: Date) async throws -> (yesterdayPosts: [Post], todayPosts: [Post], tomorrowPosts: [Post]) {
        let calendar = Calendar.current
        
        // Define start and end of yesterday, today, and tomorrow
        let startOfYesterday = calendar.startOfDay(for: calendar.date(byAdding: .day, value: -1, to: referenceDate)!)
        let startOfToday = calendar.startOfDay(for: referenceDate)
        let endOfTomorrow = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: calendar.date(byAdding: .day, value: 1, to: referenceDate)!)!
        
        // Fetch
        let snapshot = try await postCollection(userId: userID)
            .whereField(Post.CodingKeys.isDraft.rawValue, isEqualTo: false)
            .whereField(Post.CodingKeys.date.rawValue, isGreaterThanOrEqualTo: startOfYesterday)
            .whereField(Post.CodingKeys.date.rawValue, isLessThanOrEqualTo: endOfTomorrow)
            .order(by: Post.CodingKeys.date.rawValue, descending: descending)
            .getDocuments()
        
        // Map to posts
        let posts = try snapshot.documents.compactMap { document in
            try document.data(as: Post.self)
        }
        
        // Categorize posts
        let yesterdayPosts = posts.filter { post in
            calendar.isDate(post.date, inSameDayAs: startOfYesterday)
        }
        
        let todayPosts = posts.filter { post in
            calendar.isDate(post.date, inSameDayAs: startOfToday)
        }
        
        let tomorrowPosts = posts.filter { post in
            calendar.isDate(post.date, inSameDayAs: calendar.date(byAdding: .day, value: 1, to: startOfToday)!)
        }
        
        return (yesterdayPosts, todayPosts, tomorrowPosts)
    }
    
    //get Month Posts And Events
    func getMonthPostsAndEvents(userID: String, descending: Bool, referenceDate: Date) async throws -> (publishedPosts: [Post], draftPosts: [Post], events: [Event]) {
        let calendar = Calendar.current

        // Get the current month and year
        let currentMonth = calendar.component(.month, from: referenceDate)
        let currentYear = calendar.component(.year, from: referenceDate)

        // Define the start and end of the current month
        guard let startOfMonth = calendar.date(from: DateComponents(year: currentYear, month: currentMonth, day: 1)),
              let endOfMonth = calendar.date(from: DateComponents(year: currentYear, month: currentMonth + 1, day: 0)) else {
            throw NSError(domain: "DateError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid date components."])
        }

        // Fetch posts
        let snapshot = try await postCollection(userId: userID)
            .whereField(Post.CodingKeys.date.rawValue, isGreaterThanOrEqualTo: startOfMonth)
            .whereField(Post.CodingKeys.date.rawValue, isLessThanOrEqualTo: endOfMonth)
            .order(by: Post.CodingKeys.date.rawValue, descending: descending)
            .getDocuments()

        // Map to posts
        let allPosts = try snapshot.documents.compactMap { document in
            try document.data(as: Post.self)
        }
        
        // Filter posts into published and draft
        let publishedPosts = allPosts.filter { !($0.isDraft ?? false) }
        let draftPosts = allPosts.filter { $0.isDraft ?? true }

        // Fetch events (Assuming you have a similar collection for events)
        let eventSnapshot = try await eventCollection(userId: userID)
            .whereField(Event.CodingKeys.startDate.rawValue, isGreaterThanOrEqualTo: startOfMonth)
            .whereField(Event.CodingKeys.startDate.rawValue, isLessThanOrEqualTo: endOfMonth)
            .order(by: Event.CodingKeys.startDate.rawValue, descending: descending)
            .getDocuments()

        // Map to events
        let events = try eventSnapshot.documents.compactMap { document in
            try document.data(as: Event.self)
        }
        
        return (publishedPosts, draftPosts, events)
    }
    
    //get Upcoming Posts And Events
    func getUpcomingPostsAndEvents(userID: String, startInDays: Int = 3, endInDays: Int = 5) async throws -> (posts: [Post], events: [Event]) {
        
        let calendar = Calendar.current
        let today = Date()
        
        // Start and end dates for the 3-to-5-day range
        let startDate = calendar.date(byAdding: .day, value: startInDays, to: today)!
        let endDate = calendar.date(byAdding: .day, value: endInDays, to: today)!
        
        // Fetch all published posts (not drafts) in the specified range
        let postsSnapshot = try await postCollection(userId: userID)
            .whereField(Post.CodingKeys.isDraft.rawValue, isEqualTo: false)
            .whereField(Post.CodingKeys.date.rawValue, isGreaterThanOrEqualTo: startDate)
            .whereField(Post.CodingKeys.date.rawValue, isLessThanOrEqualTo: endDate)
            .order(by: Post.CodingKeys.date.rawValue)
            .getDocuments()
        
        let posts = try postsSnapshot.documents.compactMap { document in
            try document.data(as: Post.self)
        }
        
        // Fetch all events in the specified range
        let eventsSnapshot = try await eventCollection(userId: userID)
            .whereField(Event.CodingKeys.startDate.rawValue, isGreaterThanOrEqualTo: startDate)
            .whereField(Event.CodingKeys.startDate.rawValue, isLessThanOrEqualTo: endDate)
            .order(by: Event.CodingKeys.startDate.rawValue)
            .getDocuments()
        
        let events = try eventsSnapshot.documents.compactMap { document in
            try document.data(as: Event.self)
        }
        
        return (posts, events)
    }
}
