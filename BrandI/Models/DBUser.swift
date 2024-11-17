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
    let name: String?
    let dateCreated: Date?
    let brand: [BarandIdentity]?
    
    init(authUser: AuthDataResultModel) {
        self.userId = authUser.uid
        self.email = authUser.email
        self.name = authUser.name
        self.dateCreated = Date()
        self.brand = []
    }
    
    // For dynamic coding where whatever other developers writes in the DB we can handel it
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email = "email"
        case name = "name"
        case dateCreated = "date_created"
        case brand = "brand"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.brand = try container.decodeIfPresent([BarandIdentity].self, forKey: .brand)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userId, forKey: .userId)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(brand, forKey: .brand)
    }
}
