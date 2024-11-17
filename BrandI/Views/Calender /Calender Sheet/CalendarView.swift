//
//  Calender.swift
//  Challange1
//
//  Created by sumaiya on 13/11/2567 BE.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var calenerviewModel: CalenderViewModel
    @EnvironmentObject var vm: AgendaViewModel
    @Environment(\.dismiss) var dismiss
    
    private let calendar: Calendar
    private let monthFormatter: DateFormatter
    private let dayFormatter: DateFormatter
    private let weekDayFormatter: DateFormatter
    private let fullFormatter: DateFormatter
    private let highlightedDates: [Date]
    
    private static var now = Date()
    
    @Binding var isAuthenticated: Bool
    @Binding var currentDate: Date
    
    @State private var selectedDate = Self.now
    @State private var navigateToCalenderMainView = false
    
    
    
    init(calendar: Calendar, isAuthenticated: Binding<Bool>, currentDate: Binding<Date>, highlightedDates: [Date]
    ) {
        self.calendar = calendar
        self._isAuthenticated = isAuthenticated
        self._currentDate = currentDate
        self.monthFormatter = DateFormatter(dateFormat: "MMMM", calendar: calendar)
        self.dayFormatter = DateFormatter(dateFormat: "d", calendar: calendar)
        self.weekDayFormatter = DateFormatter(dateFormat: "EEEEE", calendar: calendar)
        self.fullFormatter = DateFormatter(dateFormat: "MMMM dd, yyyy", calendar: calendar)
        self.highlightedDates = highlightedDates
    }
    
    var body: some View {
        NavigationView {
            VStack {
                CalendarViewComponent(
                    calendar: calendar,
                    date: $selectedDate,
                    content: { date in
                        VStack {
                            Text(dayFormatter.string(from: date))
                                .padding(8)
                                .foregroundColor(calendar.isDateInToday(date) ? Color.white : .primary)
                                .background(
                                    ZStack {
                                        if calendar.isDateInToday(date) {
                                            Color("BabyBlue")
                                        } else if highlightedDates.contains(where: { calendar.isDate($0, inSameDayAs: date) }) {
                                            Color("BabyBlue").opacity(0.3)
                                        } else if calendar.isDate(date, inSameDayAs: selectedDate) {
                                            Color.gray
                                        } else {
                                            Color.clear
                                        }
                                    }
                                        .cornerRadius(7)
                                        .padding(.vertical, 4) // Add padding to the background
                                    
//                                    calendar.isDateInToday(date) ? Color("BabyBlue")
//                                    : highlightedDates.contains { calendar.isDate($0, inSameDayAs: date) } ? Color("BabyBlue").opacity(0.3)
//                                    : calendar.isDate(date, inSameDayAs: selectedDate) ? .gray
//                                    : .clear
                                )
                                .frame(maxHeight: .infinity)
                                .contentShape(Rectangle())
                                .cornerRadius(7)
                                .onTapGesture {
                                    selectedDate = date
                                    currentDate = date
                                    
                                    // to show it in the main calendar
                                    calenerviewModel.currentDate = date
                                    calenerviewModel.fetchCurrentMonth()
                                    vm.getAllInDay(date: date)
                                    
                                    dismiss()
                                    print("User clicked date: ⛅️ ⛅️ \(fullFormatter.string(from: date))")
                                }
                            
                            NavigationLink(
                                destination: CalenderMainView(isAuthenticated: $isAuthenticated),
                                isActive: $navigateToCalenderMainView
                            ) {
                                EmptyView()
                            }
                        }
                    },
                    trailing: { date in
                        Button(action: { selectedDate = date }) {
                            Text(dayFormatter.string(from: date))
                                .padding(8)
                                .foregroundColor(calendar.isDateInToday(date) ? .white : .gray)
                                .background(
                                    calendar.isDateInToday(date) ? .green
                                    : calendar.isDate(date, inSameDayAs: selectedDate) ? .gray
                                    : .clear
                                )
                                .cornerRadius(7)
                        }
                    },
                    header: { date in
                        Text(weekDayFormatter.string(from: date)).fontWeight(.bold)
                    },
                    title: { date in
                        HStack {
                            Text(monthFormatter.string(from: date))
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(Color("BabyBlue"))
                                .padding(.vertical, 8)
                            Spacer()
                        }
                    }
                )
            }.padding()
        }
    }
}
// MARK: - Component

public struct CalendarViewComponent<Day: View, Header: View, Title: View, Trailing: View>: View {
    
    private var calendar: Calendar
    private var months: [Date] = []
    @Binding private var date: Date
    private let content: (Date) -> Day
    private let trailing: (Date) -> Trailing
    private let header: (Date) -> Header
    private let title: (Date) -> Title
    
    let spaceName = "scroll"
    @State var wholeSize: CGSize = .zero
    @State var scrollViewSize: CGSize = .zero
    @State private var isInitialScroll = true
    private let daysInWeek = 7
    
    public init(
        calendar: Calendar,
        date: Binding<Date>,
        @ViewBuilder content: @escaping (Date) -> Day,
        @ViewBuilder trailing: @escaping (Date) -> Trailing,
        @ViewBuilder header: @escaping (Date) -> Header,
        @ViewBuilder title: @escaping (Date) -> Title
    ) {
        self.calendar = calendar
        self._date = date
        self.content = content
        self.trailing = trailing
        self.header = header
        self.title = title
        self.months = makeMonths()
    }
    
    public var body: some View {
        ScrollViewReader { scrollViewProxy in
            ChildSizeReader(size: $wholeSize) {
                ScrollView {
                    ChildSizeReader(size: $scrollViewSize) {
                        VStack {
                            ForEach(months, id: \.self) { month in
                                VStack {
                                    let month = month.startOfMonth(using: calendar)
                                    let days = makeDays(from: month)
                                    
                                    Section(header: title(month)) { }
                                        .id(month) // Set unique ID for each month
                                    VStack {
                                        LazyVGrid(columns: Array(repeating: GridItem(), count: daysInWeek)) {
                                            ForEach(days.prefix(daysInWeek), id: \.self, content: header)
                                        }
                                        Divider()
                                        LazyVGrid(columns: Array(repeating: GridItem(), count: daysInWeek)) {
                                            ForEach(days, id: \.self) { date in
                                                if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                                                    content(date)
                                                } else {
                                                    trailing(date)
                                                }
                                            }
                                        }
                                    }
                                    .frame(height: days.count == 42 ? 300 : 270)
                                    .background(Color.white)
                                }
                            }
                        }
                        .onAppear {
                            // Scroll to the current month on appear
                            if isInitialScroll, let currentMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: Date())) {
                                scrollViewProxy.scrollTo(currentMonth, anchor: .top)
                                isInitialScroll = false
                            }
                        }
                    }
                }
                .coordinateSpace(name: spaceName)
                .scrollIndicators(.never)
            }
        }
    }
}

// MARK: - Conformances

extension CalendarViewComponent: Equatable {
    public static func == (lhs: CalendarViewComponent<Day, Header, Title, Trailing>, rhs: CalendarViewComponent<Day, Header, Title, Trailing>) -> Bool {
        lhs.calendar == rhs.calendar && lhs.date == rhs.date
    }
}

// MARK: - Helpers

private extension CalendarViewComponent {
    func makeMonths() -> [Date] {
        guard let yearInterval = calendar.dateInterval(of: .year, for: date),
              let yearFirstMonth = calendar.dateInterval(of: .month, for: yearInterval.start),
              let yearLastMonth = calendar.dateInterval(of: .month, for: yearInterval.end - 1)
        else {
            return []
        }
        
        let dateInterval = DateInterval(start: yearFirstMonth.start, end: yearLastMonth.end)
        return calendar.generateDates(for: dateInterval, matching: calendar.dateComponents([.day], from: dateInterval.start)
        )
    }
    
    func makeDays(from date: Date) -> [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: date),
              let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
              let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end - 1)
        else {
            return []
        }
        
        let dateInterval = DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end)
        return calendar.generateDays(for: dateInterval)
    }
}

private extension Calendar {
    func generateDates(
        for dateInterval: DateInterval,
        matching components: DateComponents) -> [Date] {
            var dates = [dateInterval.start]
            
            enumerateDates(
                startingAfter: dateInterval.start,
                matching: components,
                matchingPolicy: .nextTime
            ) { date, _, stop in
                guard let date = date else { return }
                
                guard date < dateInterval.end else {
                    stop = true
                    return
                }
                
                dates.append(date)
            }
            
            return dates
        }
    
    func generateDays(for dateInterval: DateInterval) -> [Date] {
        generateDates(
            for: dateInterval,
            matching: dateComponents([.hour, .minute, .second], from: dateInterval.start)
        )
    }
}

private extension Date {
    func startOfMonth(using calendar: Calendar) -> Date {
        calendar.date(
            from: calendar.dateComponents([.year, .month], from: self)
        ) ?? self
    }
}

private extension DateFormatter {
    convenience init(dateFormat: String, calendar: Calendar) {
        self.init()
        self.dateFormat = dateFormat
        self.calendar = calendar
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct ChildSizeReader<Content: View>: View {
    @Binding var size: CGSize
    
    let content: () -> Content
    var body: some View {
        ZStack {
            content().background(
                GeometryReader { proxy in
                    Color.clear.preference(
                        key: SizePreferenceKey.self,
                        value: proxy.size
                    )
                }
            )
        }
        .onPreferenceChange(SizePreferenceKey.self) { preferences in
            self.size = preferences
        }
    }
}

struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: Value = .zero
    
    static func reduce(value _: inout Value, nextValue: () -> Value) {
        _ = nextValue()
    }
}
