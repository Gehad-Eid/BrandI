//
//  post.swift
//  Challange1
//
//  Created by Gehad Eid on 19/10/2024.
//

import Foundation

struct Post: Codable, Identifiable {
    var id: String { postId } // This makes "postId" the identifier
    let postId: String
    let title: String
    let content: String
    let date: Date
    let isDraft: Bool?
    let images: [String]?
    let platforms: [String]?
    let recommendation: String?
    
    init (postId: String,
          title: String,
          content: String,
          date: Date,
          images: [String]? = nil,
          platforms: [String]? = nil,
          recommendation: String? = nil,
          isDraft: Bool? = nil
    ) {
        self.postId = postId
        self.title = title
        self.content = content
        self.date = date
        self.images = images
        self.platforms = platforms
        self.recommendation = recommendation
        self.isDraft = isDraft
    }
    
    enum CodingKeys: String, CodingKey {
        case postId = "post_id"
        case title = "title"
        case content = "content"
        case date = "start_date"
        case images = "images"
        case platforms = "platforms"
        case recommendation = "recommendation"
        case isDraft = "is_draft"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.postId = try container.decode(String.self, forKey: .postId)
        self.title = try container.decode(String.self, forKey: .title)
        self.content = try container.decode(String.self, forKey: .content)
        self.date = try container.decode(Date.self, forKey: .date)
        self.images = try container.decodeIfPresent([String].self, forKey: .images)
        self.platforms = try container.decodeIfPresent([String].self, forKey: .platforms)
        self.recommendation = try container.decodeIfPresent(String.self, forKey: .recommendation)
        self.isDraft = try container.decodeIfPresent(Bool.self, forKey: .isDraft)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(postId, forKey: .postId)
        try container.encode(title, forKey: .title)
        try container.encode(content, forKey: .content)
        try container.encode(date, forKey: .date)
        try container.encodeIfPresent(images, forKey: .images)
        try container.encodeIfPresent(platforms, forKey: .platforms)
        try container.encodeIfPresent(recommendation, forKey: .recommendation)
        try container.encodeIfPresent(isDraft, forKey: .isDraft)
    }
}