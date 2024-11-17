//
//  WeeklyScrollView.swift
//  project2
//
//  Created by sumaiya on 25/10/2567 BE.
//


import SwiftUI


struct WeeklyScrollView: View {
    @EnvironmentObject var agendaViewModel: AgendaViewModel
    @EnvironmentObject var calenerviewModel : CalenderViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    calenerviewModel.previousMonth()
                }) {
                    Image(systemName:"chevron.backward")
                        .foregroundColor(.babyBlue)
                }
                Spacer()
                Button(action: {
                    calenerviewModel.nextMonth()
                }) {
                    Image(systemName:"chevron.right")
                        .foregroundColor(.babyBlue)
                }
            }
            .padding(.horizontal)
            
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(calenerviewModel.currentMonthDates, id: \.self) { date in
                            VStack(spacing: 10) {
                                // Day abbreviation (e.g., Sat)
                                Text(calenerviewModel.dateToString(date: date, format: "E"))
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("Text"))
                                
                                // Date (e.g., 28)
                                Text(calenerviewModel.dateToString(date: date, format: "dd"))
                                    .font(.system(size: 14))
                                    .fontWeight(.bold)
                                    .foregroundColor(calenerviewModel.isToday(date: date) ? .white : Color("Text"))
                                    .padding(2)
                                    .background(
                                        ZStack {
                                            if calenerviewModel.isToday(date: date) {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color("BabyBlue"))
                                                    .frame(width: 35, height: 35)
                                            }
                                        }
                                    )
                            }
                            .padding(.horizontal)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.clear)
                            )
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    calenerviewModel.currentDate = date
                                    agendaViewModel.getAllInDay(date: date)
                                }
                            }
                            .id(date)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                }
                .onAppear {
                    // Scroll to today's date when the view appears
                    scrollToCurrentDate(proxy: proxy)
                }
                .onChange(of: calenerviewModel.currentDate) { _ in
                    // Scroll to today's date when the date changes
                    scrollToCurrentDate(proxy: proxy)
                }
                .onChange(of: calenerviewModel.currentMonthDates) { _ in
                    scrollToCurrentDate(proxy: proxy)
                }
            }
            
            Divider()
            
            Text(self.calenerviewModel.currentDate.formatted(.dateTime.year().month(.wide).day().weekday(.wide)))
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(Color("Text"))
                .padding(.horizontal)
            
            Divider()
            
        }
        .onAppear {
            // if the "Show All" presseed on the Agenda view
            if let currentDate = calenerviewModel.currentDateFromAgenda {
                calenerviewModel.currentDate = currentDate
                agendaViewModel.getAllInDay(date: currentDate)
                calenerviewModel.currentDateFromAgenda = nil
            }
            else {
                // Set the current date to today's date if it's the first load
                calenerviewModel.currentDate = Date()
                agendaViewModel.getAllInDay(date: Date())
            }
        }
    }
    
    // Scroll to the current date and center it in the view
    private func scrollToCurrentDate(proxy: ScrollViewProxy) {
        DispatchQueue.main.async {
            if let today = calenerviewModel.currentMonthDates.first(where: { calenerviewModel.isToday(date: $0) }) {
                withAnimation {
                    proxy.scrollTo(today, anchor: .center)
                }
            }
        }
    }
}
