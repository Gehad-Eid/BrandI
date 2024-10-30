//
//  Post.swift
//  project2
//
//  Created by sumaiya on 24/10/2567 BE.
//
import SwiftUI
import SwiftData

//@MainActor
@Model
class Task1: Identifiable {
    var id: UUID
    var title: String
    var date: Date
    var isCompleted: Bool
    
    init(id: UUID = .init(), title: String, date: Date, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.date = date
        self.isCompleted = isCompleted
    }
}

//var sampleTask: [Task] = [
//    .init(title: "Standup", date: Date.now),
//    .init(title: "UI Design", date: Date.now)
//    ]

extension Date {
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
    
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}