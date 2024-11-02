//
//  post.swift
//  Challange1
//
//  Created by Gehad Eid on 19/10/2024.
//

import Foundation

struct ImageData: Codable, Hashable {
    let imageUrl: String
    let path: String
    let name: String
    
    init(imageUrl: String,
         path: String,
         name: String
    ) {
        self.imageUrl = imageUrl
        self.path = path
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case path = "path"
        case name = "name"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.path = try container.decode(String.self, forKey: .path)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(imageUrl, forKey: .imageUrl)
        try container.encode(path, forKey: .path)
        try container.encode(name, forKey: .name)
    }
}

struct Post: Identifiable, Codable, Hashable {
    var id: String { postId } // This makes "postId" the identifier
    let postId: String
    let title: String
    let content: String
    let date: Date
    let platforms: [Platform]?
    let isDraft: Bool?
    let images: [ImageData]?
    let recommendation: String?
        
    init (postId: String,
          title: String,
          content: String,
          date: Date,
          images: [ImageData]? = nil,
          platforms: [Platform]? = nil,
          recommendation: String? = nil,
          isDraft: Bool? = false
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
//        case imagesPaths = "images_paths"
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
        self.images = try container.decodeIfPresent([ImageData].self, forKey: .images)
        self.platforms = try container.decodeIfPresent([Platform].self, forKey: .platforms)
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
    
    func toggleIsDraft() -> Post{
        let currentIsDraft = isDraft ?? false
        
        return Post(postId: postId,
                    title: title,
                    content: content,
                    date: date,
                    images: images,
                    platforms: platforms,
                    recommendation: recommendation,
                    isDraft: !currentIsDraft
        )
    }
}
