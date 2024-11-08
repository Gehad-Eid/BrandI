//
//  MainView.swift
//  Challange1
//
//  Created by sumaiya on 21/10/2567 BE.
//

import SwiftUI
import _AppIntents_SwiftUI

struct AgendaView: View {
    @EnvironmentObject var vm: AgendaViewModel

    @State private var isButtonOn = true
    @State private var showingAddPostView = false
    @State private var tipIsShown = true
    
    @ObservedObject var calenerviewModel: CalenderViewModel
    @Binding var mainTabSelection: Int
    @Binding var isAuthenticated: Bool
    
//    @StateObject var vm = AgendaViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading) {
                            // Header
                            HeaderView(showingAddPostView: $showingAddPostView, isAuthenticated: $isAuthenticated)
                            
//                            // Siri notification
//                            SiriTipView (
//                                intent: AddPostIntent(),
//                                isVisible: $tipIsShown
//                            )
                            
                            if isAuthenticated {
                                // Month details
                                MonthInfoView(EventsCount: vm.thisMonthEvents?.count ?? 0, PostsCount: vm.thisMonthPosts?.count ?? 0, DraftsCount: vm.thisMonthDraftPosts?.count ?? 0)
                                
                                // Upcoming events and posts for the next week
                                if vm.upcomingItems?.isEmpty == false {
                                    UpcomingView(calenerviewModel: calenerviewModel,/* vm: vm,*/ mainTabSelection: $mainTabSelection)
                                }
                                
                                // Yesterday, today, and tomorrow's Posts
                                UpcomingRecentPostsView(/*vm: vm, */calenerviewModel: calenerviewModel, mainTabSelection: $mainTabSelection, isAuthenticated: $isAuthenticated)
                            }
                            else {
                                // Month details
                                MonthInfoView(EventsCount: 0, PostsCount: 0, DraftsCount: 0)
                                
                                // Yesterday, today, and tomorrow's Posts
                                UpcomingRecentPostsView(/*vm: vm, */calenerviewModel: calenerviewModel, mainTabSelection: $mainTabSelection, isAuthenticated: $isAuthenticated)
                            }
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
    AgendaView(calenerviewModel: CalenderViewModel(), mainTabSelection: .constant(0), isAuthenticated: .constant(false))
}
