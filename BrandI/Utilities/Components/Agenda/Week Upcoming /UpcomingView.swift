//
//  UpcomingView.swift
//  Challange1
//
//  Created by Gehad Eid on 04/11/2024.
//

import SwiftUI

struct UpcomingView: View {
    @EnvironmentObject var vm: AgendaViewModel

    @ObservedObject var calenerviewModel: CalenderViewModel
//    @ObservedObject var vm: AgendaViewModel
    @Binding var mainTabSelection: Int

    @State private var selectedDay = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("Upcoming this week")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, -30)
            
//            if let dec = vm.getCountsForUpcomingDays() {
                TabView(selection: $selectedDay) {
                    ForEach(Array(vm.getCountsForUpcomingDays().sorted { $0.key < $1.key }), id: \.key) { (day, counts) in
                        let postCount = counts.postCount
                        let eventCount = counts.eventCount
                        let date = counts.date
                        
                        if !(eventCount == 0 && postCount == 0) {
                            UpcomingDayView(calenerviewModel: calenerviewModel, mainTabSelection: $mainTabSelection, counts: (postCount, eventCount, date), day: day.description)
                        }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                .accentColor(Color("BabyBlue"))
                .frame(height: 150)
//            }
//            // Custom Page Indicator
//            PageIndicator(currentPage: $selectedDay, numberOfPages: vm.getCountsForUpcomingDays().count)
//                .padding(.top, 8)
        }
    }
}

/* TabView(selection: $selectedDay) {
 ForEach(Array(vm.getCountsForUpcomingDays()), id: \.key) { key, value in
     let counts = value ?? (postCount: 0, eventCount: 0, date: Date())
     if !(counts.eventCount == 0 && counts.postCount == 0) {
         UpcomingDayView(counts: counts, day: key, calenerviewModel: calenerviewModel, mainTabSelection: mainTabSelection)
     }
 }
}*/
