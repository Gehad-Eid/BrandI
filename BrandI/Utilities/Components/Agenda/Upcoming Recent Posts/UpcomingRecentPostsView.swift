//
//  UpcomingRecentPostsView.swift
//  Challange1
//
//  Created by Gehad Eid on 04/11/2024.
//

import SwiftUI

struct UpcomingRecentPostsView: View {
    @EnvironmentObject var vm: AgendaViewModel
    @EnvironmentObject var calenerviewModel: CalenderViewModel
    
    @Binding var mainTabSelection: Int
    @Binding var isAuthenticated: Bool
    
    @State private var selectedDay = 1
    
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
                    calenerviewModel.currentDateFromAgenda = vm.getFormattedDate(forDayOffset: selectedDay).date ?? Date()
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
        }
        .onAppear {
            setupAppearance()
        }
    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(named: "BabyBlue") 
        UIPageControl.appearance().pageIndicatorTintColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark
                ? UIColor.white.withAlphaComponent(0.2)
                : UIColor.black.withAlphaComponent(0.2)
        }
    }


}
