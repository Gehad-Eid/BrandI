//
//  event.swift
//  Challange1
//
//  Created by Gehad Eid on 19/10/2024.
//

import Foundation

struct Event: Codable {
    let eventId: String
    let title: String
    let content: String
    let startDate: Date
    let endDate: Date
}
