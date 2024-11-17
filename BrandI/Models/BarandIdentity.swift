//
//  BarandIdentity.swift
//  BrandI
//
//  Created by Gehad Eid on 17/11/2024.
//

import Foundation

struct BarandIdentity: Codable, Hashable {
    let purpose: String
    let audience: String
    let category: String
    let colors: String
    let name: String
    
    init(purpose: String,
         audience: String,
         category: String,
         colors: String,
         name: String
    ) {
        self.purpose = purpose
        self.audience = audience
        self.category = category
        self.colors = colors
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case purpose = "purpose"
        case audience = "audience"
        case category = "category"
        case colors = "colors"
        case name = "name"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.purpose = try container.decode(String.self, forKey: .purpose)
        self.audience = try container.decode(String.self, forKey: .audience)
        self.category = try container.decode(String.self, forKey: .category)
        self.colors = try container.decode(String.self, forKey: .colors)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(purpose, forKey: .purpose)
        try container.encode(audience, forKey: .audience)
        try container.encode(category, forKey: .category)
        try container.encode(colors, forKey: .colors)
        try container.encode(name, forKey: .name)
    }
}
