//
//  TaskViewModel.swift
//  project2
//
//  Created by sumaiya on 24/10/2567 BE.
//

import Foundation


class TaskViewModel: ObservableObject {
    @Published var allWeeks: [Week] = []
    @Published var currentDate: Date = Date()
    
    @Published var currentIndex: Int = 0
    @Published var indexToUpdate: Int = 0
    
    @Published var currentWeek: [Date] = []
    @Published var nextWeek: [Date] = []
    @Published var previousWeek: [Date] = []
    //
    @Published var currentMonthDates: [Date] = []
    @Published var allMonths: [[Date]] = []
      
    
    init() {
        currentDate = Date()
        fetchCurrentWeek()
        fetchPreviousNextWeek()
        appendAll()
        //
        fetchCurrentMonth()
        
    }
    //new
    func isSameMonth(date: Date, referenceDate: Date) -> Bool {
            let calendar = Calendar.current
            return calendar.component(.month, from: date) == calendar.component(.month, from: referenceDate) &&
                   calendar.component(.year, from: date) == calendar.component(.year, from: referenceDate)
        }
    //work
//    func fetchCurrentMonth() {
//            let calendar = Calendar.current
//            let range = calendar.range(of: .day, in: .month, for: currentDate)!
//            let components = calendar.dateComponents([.year, .month], from: currentDate)
//            currentMonthDates = range.compactMap { day -> Date? in
//                var dateComponents = components
//                dateComponents.day = day
//                return calendar.date(from: dateComponents)
//            }
//        }
    // Fetch the current month dates based on the currentDate
    
    // Navigate to the previous month and fetch its dates
        func previousMonth() {
            currentDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) ?? currentDate
            fetchCurrentMonth()
        }
        func fetchCurrentMonth() {
            let calendar = Calendar.current
            let range = calendar.range(of: .day, in: .month, for: currentDate)!
            let components = calendar.dateComponents([.year, .month], from: currentDate)
            
            currentMonthDates = range.compactMap { day -> Date? in
                var dateComponents = components
                dateComponents.day = day
                return calendar.date(from: dateComponents)
            }
        }
        
    
    // Navigate to the next month and fetch its dates
       func nextMonth() {
           currentDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate) ?? currentDate
           fetchCurrentMonth()
       }
    //
    
    
    /////
    func appendAll() {
        var newWeek = Week(id: 0, date: currentWeek)
        allWeeks.append(newWeek)
        
        newWeek = Week(id: 2, date: nextWeek)
        allWeeks.append(newWeek)
        
        newWeek = Week(id: 1, date: previousWeek)
        allWeeks.append(newWeek)
    }
    
    func update(index: Int) {
        var value: Int = 0
        if index < currentIndex {
            value = 1
            if indexToUpdate == 2 {
                indexToUpdate = 0
            } else {
                indexToUpdate = indexToUpdate + 1
            }
        } else {
            value = -1
            if indexToUpdate == 0 {
                indexToUpdate = 2
            } else {
                indexToUpdate = indexToUpdate - 1
            }
        }
        currentIndex = index
        addWeek(index: indexToUpdate, value: value)
    }
    
    func addWeek(index: Int, value: Int) {
        allWeeks[index].date.removeAll()
        var calendar = Calendar(identifier: .gregorian)
        let today = Calendar.current.date(byAdding: .day, value: 7 * value, to: self.currentDate)!
        self.currentDate = today
        
        calendar.firstWeekday = 7
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
        
        (0...6).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeek) {
                allWeeks[index].date.append(weekday)
            }
        }
    }
    
    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(currentDate, inSameDayAs: date)
    }
    
    func isCurrentDate(_ date1: Date, _ date2: Date) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
    
    func dateToString(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func fetchCurrentWeek() {
        let today = currentDate
        var calendar = Calendar(identifier: .gregorian)
        
        calendar.firstWeekday = 7
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
        
        (0...6).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeek) {
                currentWeek.append(weekday)
            }
        }
    }
    
    func fetchPreviousNextWeek() {
        nextWeek.removeAll()
        
        let nextWeekToday = Calendar.current.date(byAdding: .day, value: 7, to: currentDate)!
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 7
        
        let startOfWeekNext = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: nextWeekToday))!
        
        (0...6).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeekNext) {
                nextWeek.append(weekday)
            }
        }
        
        previousWeek.removeAll()
        let previousWeekToday = Calendar.current.date(byAdding: .day, value: -7, to: currentDate)!
        
        let startOfWeekPrev = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: previousWeekToday))!
        
        (0...6).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeekPrev) {
                previousWeek.append(weekday)
            }
        }
    }
}
