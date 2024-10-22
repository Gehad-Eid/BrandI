//
//  event.swift
//  Challange1
//
//  Created by Gehad Eid on 19/10/2024.
//

import Foundation

struct Event: Codable , Identifiable {
    var id: String { eventId } // This makes "eventId" the identifier
    let eventId: String
    let title: String
    let content: String
    let startDate: Date
    let endDate: Date
    
    init(eventId: String, title: String, content: String, startDate: Date, endDate: Date) {
        self.eventId = eventId
        self.title = title
        self.content = content
        self.startDate = startDate
        self.endDate = endDate
    }
    
    enum CodingKeys: String, CodingKey {
        case eventId = "event_id"
        case title = "title"
        case content = "content"
        case startDate = "start_date"
        case endDate = "end_date"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.eventId = try container.decode(String.self, forKey: .eventId)
        self.title = try container.decode(String.self, forKey: .title)
        self.content = try container.decode(String.self, forKey: .content)
        self.startDate = try container.decode(Date.self, forKey: .startDate)
        self.endDate = try container.decode(Date.self, forKey: .endDate)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(eventId, forKey: .eventId)
        try container.encode(title, forKey: .title)
        try container.encode(content, forKey: .content)
    }
}

