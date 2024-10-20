//
//  DBUser.swift
//  Challange1
//
//  Created by Gehad Eid on 19/10/2024.
//

import Foundation

struct DBUser : Codable {
    let userId: String
    let email: String?
    let dateCreated: Date?
    let posts: [Post]?
    let events: [Event]?
    
    init(authUser: AuthDataResultModel) {
        self.userId = authUser.uid
        self.email = authUser.email
        self.dateCreated = Date()
        self.posts = nil
        self.events = nil
    }
    
    // For dynamic coding where whatever other developers writes in the DB we can handel it in 2 sec
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email = "email"
        case dateCreated = "date_created"
        case posts = "posts"
        case events = "events"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.posts = try container.decodeIfPresent([Post].self, forKey: .posts)
        self.events = try container.decodeIfPresent([Event].self, forKey: .events)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userId, forKey: .userId)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(posts, forKey: .posts)
        try container.encodeIfPresent(events, forKey: .events)
    }
}
