//
//  ImageData.swift
//  Challange1
//
//  Created by Gehad Eid on 31/10/2024.
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
