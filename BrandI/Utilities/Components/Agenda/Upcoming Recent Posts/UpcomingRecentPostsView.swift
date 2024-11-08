//
//  UpcomingRecentPostsView.swift
//  Challange1
//
//  Created by Gehad Eid on 04/11/2024.
//


import SwiftUI

struct UpcomingRecentPostsView: View {
    @EnvironmentObject var vm: AgendaViewModel
    
    @ObservedObject var calenerviewModel: CalenderViewModel
    @Binding var mainTabSelection: Int

    @State private var selectedDay = 1
    @Binding var isAuthenticated: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            // Date representation
            HStack {
                Text(vm.getFormattedDate(forDayOffset: selectedDay).formattedDate ?? "No Date")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button("Show All") {
                    mainTabSelection = 1 // Switch to Calendar tab in MainTabView
                    calenerviewModel.currentDate = vm.getFormattedDate(forDayOffset: selectedDay).date ?? Date()
                }
                .foregroundColor(Color("BabyBlue"))
            }
            .zIndex(1)
            
            if isAuthenticated {
                // Post Cards
                TabView(selection: $selectedDay) {
                    DailyCardView(posts: vm.yesterdayPosts ?? []).tag(0)
                    DailyCardView(posts: vm.todayPosts ?? []).tag(1)
                    DailyCardView(posts: vm.tomorrowPosts ?? []).tag(2)
                }
                .frame(height: 390, alignment: .top)
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                
            } else {
                // Post Cards
                TabView(selection: $selectedDay) {
                    DailyCardView(posts: []).tag(0)
                    DailyCardView(posts: []).tag(1)
                    DailyCardView(posts: []).tag(2)
                }
                .frame(height: 390, alignment: .top)
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            }
            
//            // Custom Page Indicator
//            PageIndicator(currentPage: $selectedDay, numberOfPages: vm.getCountsForUpcomingDays().count)
//                .padding(.top, 8)
        }.onAppear {
            setupAppearance()
          }
    }
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .babyBlue
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
      }
}
