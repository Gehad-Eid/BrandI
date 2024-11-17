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
    
    @Published private(set) var AllPostsAndEvents: [Any]? = nil
    @Published private(set) var AllPostsAndEventsInDate: [Any]? = nil
    
    @Published private(set) var thisMonthPosts: [Post]? = nil
    @Published private(set) var thisMonthEvents: [Event]? = nil
    @Published private(set) var thisMonthDraftPosts: [Post]? = nil
    
    @Published private(set) var yesterdayPosts: [Post]? = nil
    @Published private(set) var todayPosts: [Post]? = nil
    @Published private(set) var tomorrowPosts: [Post]? = nil
    
    @Published private(set) var upcomingPosts: [Post]? = nil
    @Published private(set) var upcomingEvents: [Event]? = nil
    @Published private(set) var upcomingItems: [Any]? = nil
    
    @Published var showSuccessNotificationMessage: String = ""
    
    @Published var updateUITrigger: Bool = false
    
    func DoneAdding(userId: String, type: String) async throws {
        
        try await loadPosts(userId: userId)
        try await loadEvents(userId: userId)
        updateUITrigger.toggle()
        
        showSuccessNotificationMessage = type
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showSuccessNotificationMessage = ""
        }
    }
    
    func loadAll(userId: String) async throws {
        if let userID = UserDefaults.standard.string(forKey: "userID") {
            try await loadPosts(userId: userID)
            try await loadEvents(userId: userID)
            try await loadMonthPostsAndEvents(userId: userID)
            try await loadRecentPosts(userId: userID)
            loadDraftPosts()
            loadUpcomingPostsAndEvents()
        } else {
            print("userID not found")
        }
    }
    
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
    
    // get upcoming posts and events within 3-5 days
    func loadUpcomingPostsAndEvents() {
        let currentDate = Date()
        let twoDaysFromNow = Calendar.current.date(byAdding: .day, value: 2, to: currentDate)!
        let sixDaysFromNow = Calendar.current.date(byAdding: .day, value: 6, to: currentDate)!
        
        // Filter upcoming posts
        var upcomingPosts: [Post] = []
        if let upposts = posts {
            upcomingPosts = upposts.filter { !($0.isDraft ?? false) && ($0.date >= twoDaysFromNow && $0.date <= sixDaysFromNow) }
        }
        
        // Filter upcoming events
        var upcomingEvents: [Event] = []
        if let uppevents = events {
            upcomingEvents = uppevents.filter { $0.startDate >= twoDaysFromNow && $0.startDate <= sixDaysFromNow }
        }
        
        // Combine upcoming posts and events into one array
        upcomingItems = upcomingPosts + upcomingEvents
    }
    
    /// Returns a dictionary where the keys are days (2, 3, 4, 5, and 6)
    /// and the values are tuples with counts of posts and events on that day.
    func getCountsForUpcomingDays() -> [Int: (postCount: Int, eventCount: Int, date: Date)] {
        var counts: [Int: (postCount: Int, eventCount: Int, date: Date)] = [:]
        let calendar = Calendar.current
        
        for daysAhead in 2...6 {
            // Calculate the target date
            let targetDate = calendar.date(byAdding: .day, value: daysAhead, to: Date())!
            
            // Filter posts for the target day
            let postCount = posts?.filter { post in
                calendar.isDate(post.date, inSameDayAs: targetDate)
            }.count ?? 0
            
            // Filter events for the target day
            let eventCount = events?.filter { event in
                calendar.isDate(event.startDate, inSameDayAs: targetDate)
            }.count ?? 0
            
            // Store the counts and date in the dictionary
            counts[daysAhead] = (postCount, eventCount, targetDate)
        }
        
        return counts
    }

    
    func getAll() {
        let allItems: [Any] = (posts ?? []) + (events ?? [])
        
        // Sort by date using a helper function to extract date
        AllPostsAndEvents = allItems.sorted { first, second in
            let date1 = extractDate(from: first) ?? Date.distantPast
            let date2 = extractDate(from: second) ?? Date.distantPast
            return date1 < date2
        }
    }
    
    func extractDates(from items: [Any]) -> [Date] {
        var dates: [Date] = []
        
        for item in items {
            if let event = item as? Event {
                dates.append(event.startDate)
            } else if let post = item as? Post {
                dates.append(post.date)
            }
        }
        
        return dates
    }
    
    func getAllInDay(date: Date) {
        let allItemsInDate: [Any] = (posts ?? []) + (events ?? [])
        
        // Filter items by the provided date
        AllPostsAndEventsInDate = allItemsInDate.filter { item in
            // Extract the date from the item and compare it to the provided date
            if let itemDate = extractDate(from: item) {
                // Compare the year, month, and day to ensure they match
                let calendar = Calendar.current
                return calendar.isDate(itemDate, inSameDayAs: date)
            }
            return false
        }
    }
    
    // Helper function to extract date based on type
    private func extractDate(from item: Any) -> Date? {
        if let post = item as? Post {
            return post.date
        } else if let event = item as? Event {
            return event.startDate
        }
        return nil
    }
    
    func getFormattedDate(forDayOffset offset: Int) -> (formattedDate: String?, date: Date?) {
        let calendar = Calendar.current
        
        // Ensure offset is between 0 and 2
        guard (0...2).contains(offset) else { return (nil, nil) }
        
        // Calculate the offset (-1 for yesterday, 0 for today, +1 for tomorrow)
        let dateOffset = offset - 1
        guard let date = calendar.date(byAdding: .day, value: dateOffset, to: Date()) else { return (nil, nil) }
        
        // Format the date
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        return (formatter.string(from: date), date)
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



//        let rangeStart = Calendar.current.startOfDay(for: threeDaysFromNow)
//        let rangeEnd = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: fiveDaysFromNow)!
//        print("Range Start: \(rangeStart)")
//        print("Range End: \(rangeEnd)")
//
//        let startOfThreeDaysFromNow = Calendar.current.startOfDay(for: threeDaysFromNow)
//        let endOfFiveDaysFromNow = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: fiveDaysFromNow)!
