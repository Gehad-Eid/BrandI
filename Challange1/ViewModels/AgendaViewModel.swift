//
//  AgendaViewModel.swift
//  Challange1
//
//  Created by Gehad Eid on 21/10/2024.
//

import Foundation

@MainActor
final class AgendaViewModel: ObservableObject {
    
    @Published private(set) var posts: [Post]? = nil
    @Published private(set) var events: [Event]? = nil
    @Published private(set) var draftPosts: [Post]? = nil
    
    @Published private(set) var thisMonthPosts: [Post]? = nil
    @Published private(set) var thisMonthEvents: [Event]? = nil
    @Published private(set) var thisMonthDraftPosts: [Post]? = nil
    
    @Published private(set) var yesterdayPosts: [Post]? = nil
    @Published private(set) var todayPosts: [Post]? = nil
    @Published private(set) var tomorrowPosts: [Post]? = nil
    
    func loadPosts(userId: String) async throws {
        self.posts = try await UserManager.shared.getUserPosts(userID: userId)
    }
    
    func loadEvents(userId: String) async throws {
        self.events = try await UserManager.shared.getUserEvents(userID: userId)
    }
    
    func loadDraftPosts() {
        guard let posts = posts else { return }
        draftPosts = posts.filter { $0.isDraft == true }
    }
    
    func loadRecentPosts(userId: String) async throws {
        // Fetch posts sorted by date, split into yesterday, today, and tomorrow categories
        let (yesterdayPosts, todayPosts, tomorrowPosts) = try await UserManager.shared.getRecentPosts(userID: userId, descending: true, referenceDate: Date())
        
        // Assign results to the properties
        self.yesterdayPosts = yesterdayPosts
        self.todayPosts = todayPosts
        self.tomorrowPosts = tomorrowPosts
    }
    
    func loadMonthPostsAndEvents(userId: String) async throws {
        // Fetch posts sorted by date, split into yesterday, today, and tomorrow categories
        let (thisMonthPosts, thisMonthDraftPosts, thisMonthEvents) = try await UserManager.shared.getMonthPostsAndEvents(userID: userId, descending: true, referenceDate: Date())
        
        // Assign results to the properties
        self.thisMonthPosts = thisMonthPosts
        self.thisMonthEvents = thisMonthEvents
        self.thisMonthDraftPosts = thisMonthDraftPosts
    }
    
    func loadPostById(userId: String, postId: String) async throws -> Post? {
        return try await UserManager.shared.getPost(userID: userId, postId: postId)
    }
    
}

//MARK: Post funcs
extension AgendaViewModel {
    // Function to get title based on item type
    func getTitle(for item: Any) -> String {
        if let post = item as? Post {
            return post.title
        } else if let event = item as? Event {
            return event.title
        }
        return "Unknown"
    }
    
    // Function to get date based on item type
    func getDate(for item: Any) -> String {
        if let post = item as? Post {
            return post.date.formatted(date: .abbreviated, time: .omitted)
        } else if let event = item as? Event {
            return event.startDate.formatted(date: .abbreviated, time: .omitted)
        }
        return "No Date"
    }
    
    // Function to get remaining date message
    func getRemainDate(for item: Any) -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        
        // Get the date from the item
        var eventDate: Date?
        if let post = item as? Post {
            eventDate = post.date
        } else if let event = item as? Event {
            eventDate = event.startDate
        }
        
        // Ensure we have a valid date
        guard let date = eventDate else {
            return "Unknown"
        }
        
        // Calculate the number of days between currentDate and eventDate
        if let daysDifference = calendar.dateComponents([.day], from: currentDate, to: date).day {
            switch daysDifference {
            case 3:
                return "In 3 days"
            case 4:
                return "In 4 days"
            case 5:
                return "In 5 days"
            default:
                return "After \(daysDifference) days"
            }
        }
        
        return "Unknown"
    }

    
    // Function to get image name based on item type
    func getImageName(for item: Any) -> String {
        if item is Post {
            return "document.fill"
        } else if item is Event {
            return "note"
        }
        return "questionmark" // Fallback image
    }
}
