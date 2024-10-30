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
    
    @Published private(set) var upcomingPosts: [Post]? = nil
    @Published private(set) var upcomingEvents: [Event]? = nil
    @Published private(set) var upcomingItems: [Any]? = nil
    
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
        
        print("thisMonthPosts::: \(thisMonthPosts)")
    }
    
    func loadPostById(userId: String, postId: String) async throws -> Post? {
        return try await UserManager.shared.getPost(userID: userId, postId: postId)
    }
    
    // get upcoming posts and events within 3-5 days
    func loadUpcomingPostsAndEvents() {
        let currentDate = Date()
        let threeDaysFromNow = Calendar.current.date(byAdding: .day, value: 3, to: currentDate)!
        let fiveDaysFromNow = Calendar.current.date(byAdding: .day, value: 5, to: currentDate)!
        
//        let rangeStart = Calendar.current.startOfDay(for: threeDaysFromNow)
//        let rangeEnd = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: fiveDaysFromNow)!
//        print("Range Start: \(rangeStart)")
//        print("Range End: \(rangeEnd)")
//        
//        let startOfThreeDaysFromNow = Calendar.current.startOfDay(for: threeDaysFromNow)
//        let endOfFiveDaysFromNow = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: fiveDaysFromNow)!

        // Filter upcoming posts
        var upcomingPosts: [Post] = []
        if let upposts = posts {
            upcomingPosts = upposts.filter { !($0.isDraft ?? false) && ($0.date >= threeDaysFromNow && $0.date <= fiveDaysFromNow) }
        }
        
        // Filter upcoming events
        var upcomingEvents: [Event] = []
        if let uppevents = events {
            upcomingEvents = uppevents.filter { $0.startDate >= threeDaysFromNow && $0.startDate <= fiveDaysFromNow }
        }
        
        // Combine upcoming posts and events into one array
        upcomingItems = upcomingPosts + upcomingEvents
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


//    func loadUpcomingPostsAndEvents() {
//        let currentDate = Date()
//        let threeDaysFromNow = Calendar.current.date(byAdding: .day, value: 3, to: currentDate)!
//        let fiveDaysFromNow = Calendar.current.date(byAdding: .day, value: 5, to: currentDate)!
//
//        // Log the date range for comparison
//        print("Date Range:")
//        print("Three Days From Now: \(threeDaysFromNow)")
//        print("Five Days From Now: \(fiveDaysFromNow)")
//
//        // Check each post's date individually
//        var filteredUpcomingPosts: [Post] = []
//        if let posts = thisMonthPosts {
//            for post in posts {
//                // Log each post's date and check it manually
//                print("Checking Post Date: \(post.date)")
//                if post.date >= threeDaysFromNow && post.date <= fiveDaysFromNow {
//                    print("Post \(post) is in the upcoming range.")
//                    filteredUpcomingPosts.append(post)
//                } else {
//                    print("Post \(post) is NOT in the upcoming range.")
//                }
//            }
//        }
//
//        // Check each event's start date individually
//        var filteredUpcomingEvents: [Event] = []
//        if let events = thisMonthEvents {
//            for event in events {
//                // Log each event's start date and check it manually
//                print("Checking Event Start Date: \(event.startDate)")
//                if event.startDate >= threeDaysFromNow && event.startDate <= fiveDaysFromNow {
//                    print("Event \(event) is in the upcoming range.")
//                    filteredUpcomingEvents.append(event)
//                } else {
//                    print("Event \(event) is NOT in the upcoming range.")
//                }
//            }
//        }
//
//        // Combine upcoming posts and events
//        upcomingItems = filteredUpcomingPosts + filteredUpcomingEvents
//        print("Upcoming Items: \(upcomingItems)")
//    }
