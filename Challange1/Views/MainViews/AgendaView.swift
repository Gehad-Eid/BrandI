//
//  MainView.swift
//  Challange1
//
//  Created by sumaiya on 21/10/2567 BE.
//

import SwiftUI
import _AppIntents_SwiftUI

struct AgendaView: View {
    @State private var isButtonOn = true
    @State private var showingAddPostView = false
    @State private var tipIsShown = true
    
    @ObservedObject var calenerviewModel: CalenderViewModel
    @Binding var mainTabSelection: Int
    
    @StateObject var vm = AgendaViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading) {
                            // Header
                            HeaderView(showingAddPostView: $showingAddPostView)
                            
                            // Siri notification
                            SiriTipView (
                                intent: AddPostIntent(),
                                isVisible: $tipIsShown
                            )
                            
                            // Month details
                            MonthInfoView(EventsCount: vm.thisMonthEvents?.count ?? 0, PostsCount: vm.thisMonthPosts?.count ?? 0, DraftsCount: vm.thisMonthDraftPosts?.count ?? 0)
                            
                            // Upcoming events and posts for the next week
                            if vm.upcomingItems?.isEmpty == false {
                                UpcomingView(calenerviewModel: calenerviewModel, vm: vm, mainTabSelection: $mainTabSelection)
                            }
                            
                            // Yesterday, today, and tomorrow's Posts
                            UpcomingRecentPostsView(vm: vm, calenerviewModel: calenerviewModel, mainTabSelection: $mainTabSelection)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.top)
            }
        }
        .onAppear() {
            Task {
                if let userID = UserDefaults.standard.string(forKey: "userID") {
                    try await vm.loadPosts(userId: userID)
                    try await vm.loadEvents(userId: userID)
                    
                    try await vm.loadMonthPostsAndEvents(userId: userID)
                    
                    try await vm.loadRecentPosts(userId: userID)
                    
                    vm.loadDraftPosts()
                    vm.loadUpcomingPostsAndEvents()
                } else {
                    print("userID not found")
                }
            }
        }
        .safeAreaPadding()
    }
}

#Preview {
    AgendaView(calenerviewModel: CalenderViewModel(), mainTabSelection: .constant(0))
}


//AppBar(EventsCount: vm.thisMonthEvents?.count, PostsCount: vm.thisMonthPosts?.count, DraftsCount: vm.thisMonthDraftPosts?.count).padding(.top, -15)

//                        if vm.upcomingItems?.isEmpty == false {
//                            UpcomingSection(vm: vm)
//                                .padding(.top, 7)
//                        } else {
//                            VStack{
//                                Text(" ")
//                            }
//                            .padding(.top, 7)
//                        }

// CardViewSection(vm: vm, mainTabSelection: $mainTabSelection) .padding(.top, 4)


/*
 private var Header: some View {
     HStack {
         Text("Agenda")
             .font(.system(size: 40, weight: .bold))
         
         Spacer()
         
         Button(action: {
             showingAddPostView.toggle()
         }) {
             Text("+")
                 .font(.system(size: 20, weight: .bold))
                 .foregroundColor(Color("Background"))
                 .frame(width: 30, height: 30)
                 .background(Color("BabyBlue"))
                 .cornerRadius(9)
//                    .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 4)
         }
//            .padding(.trailing, 5)
         .sheet(isPresented: $showingAddPostView) {
             CreatePostView(post: nil)
         }
     }
 }
 
 private var monthInfo: some View {
     VStack(alignment: .leading, spacing: 5) {
         Text("This Month")
             .font(.title3)
             .fontWeight(.bold)
         
         HStack(spacing: 15) {
             MonthInfo(
                 iconName: "calendar",
                 count: vm.thisMonthEvents?.count ?? 0,
                 title: "Events"
                 //destination: AnyView(CalenderMainView())
             )
             
             MonthInfo(
                 iconName: "document.fill",
                 count: vm.thisMonthPosts?.count ?? 0,
                 title: "Posts"
                 //destination: AnyView(CalenderMainView())
             )
             
             MonthInfo(
                 iconName: "pencil",
                 count: vm.thisMonthDraftPosts?.count ?? 0,
                 title: "Drafts"
                 //destination: AnyView(CalenderMainView())
             )
         }
     }
     .padding(.vertical)
 }
 
 private var upcoming: some View {
     VStack(alignment: .leading, spacing: 3) {
         Text("Upcoming this week")
             .font(.title3)
             .fontWeight(.bold)
             .padding(.bottom, -30)
         
         TabView {
             ForEach(Array(vm.getCountsForUpcomingDays().keys.sorted()), id: \.self) { day in
                 let counts = vm.getCountsForUpcomingDays()[day] ?? (postCount: 0, eventCount: 0)
                 if !(counts.eventCount == 0 && counts.postCount == 0) {
                     VStack(alignment: .leading, spacing: 5) {
                         Text("In \(day) days")
                             .bold()
                             .padding(.horizontal)
                         
                         HStack {
                             HStack {
                                 Image(systemName: "document.fill")
                                     .resizable()
                                     .foregroundColor(Color("BabyBlue"))
                                     .frame(width: 13, height: 13)
                                 
                                 Text("\(counts.postCount) Posts")
                                     .foregroundColor(Color("BabyBlue"))
                             }
                             
                             Image(systemName: "dot.circle")
                                 .resizable()
                                 .foregroundColor(Color("BabyBlue"))
                                 .frame(width: 13, height: 13)
                             
                             HStack {
                                 Image(systemName: "calendar")
                                     .resizable()
                                     .foregroundColor(Color("BabyBlue"))
                                     .frame(width: 13, height: 13)
                                 
                                 Text("\(counts.eventCount) Events")
                                     .foregroundColor(Color("BabyBlue"))
                             }
                         }
                         .padding(.horizontal)
                     }
                     .frame(width: 350, height: 80, alignment: .leading)
                     .background(Color("BoxColor"))
                     .cornerRadius(18)
                     .padding(.horizontal)
                 }
             }
         }
         .background(Color.yellow)
         .tabViewStyle(.page(indexDisplayMode: .always))
         .indexViewStyle(.page(backgroundDisplayMode: .interactive))
         .accentColor(Color("BabyBlue"))
         .frame(height: 150)
     }
 }
 
 private var upcomingRecentPosts: some View {
     VStack(alignment: .leading, spacing: 3) {
         // Date represntaion
         HStack {
             Text(vm.getFormattedDate(forDayOffset: selectedDay) ?? "No Date")
                 .font(.title3)
                 .fontWeight(.bold)
             
             Spacer()
             
             Button("Show All") {
                 mainTabSelection = 1 // Switch to Calendar tab in MainTabView
             }
             .foregroundColor(Color("BabyBlue"))
         }
         .zIndex(1)
         
         TabView(selection: $selectedDay) {
             DailyCardView(posts: vm.yesterdayPosts ?? [])
                 .tag(0)

             
             DailyCardView(posts: vm.todayPosts ?? [])
                 .tag(1)
             
             
             DailyCardView(posts: vm.tomorrowPosts ?? [])
                 .tag(2)
         }
         .frame(height: 390, alignment: .top)
         .tabViewStyle(.page(indexDisplayMode: .always))
         .indexViewStyle(.page(backgroundDisplayMode: .interactive))
     }
 }*/
