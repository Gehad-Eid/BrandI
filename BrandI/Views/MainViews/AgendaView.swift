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
    @EnvironmentObject var calenerviewModel: CalenderViewModel
    
    @State private var isButtonOn = true
    @State private var showingAddPostView = false
    @State private var tipIsShown = true
    
    @Binding var mainTabSelection: Int
    @Binding var isAuthenticated: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                
                VStack {
                    // Success notification
                    if !vm.showSuccessNotificationMessage.isEmpty {
                        Text("\(vm.showSuccessNotificationMessage)")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(8)
                            .transition(.move(edge: .top))
                            .animation(.easeInOut)
                    }
                    
                    Spacer()
                }
                .zIndex(100)
                
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading) {
                            // Header
                            HeaderView(showingAddPostView: $showingAddPostView, isAuthenticated: $isAuthenticated)
                            
                            
                            if isAuthenticated {
                                // Siri Tip
                                SiriTipView (
                                    intent: AddPostIntent(),
                                    isVisible: $tipIsShown
                                )
                                .accessibilityLabel("Add Post Shortcut") // Add VoiceOver accessibility label
                                .accessibilityHint("Use Siri to quickly add a post") // Hint for VoiceOver
                                .accessibilityAddTraits(.isButton) // VoiceOver will treat it like a button
                                
                                // Month details
                                MonthInfoView(EventsCount: vm.thisMonthEvents?.count ?? 0, PostsCount: vm.thisMonthPosts?.count ?? 0, DraftsCount: vm.thisMonthDraftPosts?.count ?? 0)
                                
                                // Upcoming events and posts for the next week
                                if vm.upcomingItems?.isEmpty == false {
                                    UpcomingView(mainTabSelection: $mainTabSelection)
                                }
                                
                                // Yesterday, today, and tomorrow's Posts
                                UpcomingRecentPostsView(mainTabSelection: $mainTabSelection, isAuthenticated: $isAuthenticated)
                            }
                            else {
                                // Month details
                                MonthInfoView(EventsCount: 0, PostsCount: 0, DraftsCount: 0)
                                
                                // Yesterday, today, and tomorrow's Posts
                                UpcomingRecentPostsView(mainTabSelection: $mainTabSelection, isAuthenticated: $isAuthenticated)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.top)
            }
        }
        .refreshable {
            Task {
                if let userID = UserDefaults.standard.string(forKey: "userID") {
                    try await vm.loadAll(userId: userID)
                } else {
                    print("userID not found")
                }
            }
        }
        .onChange(of: vm.updateUITrigger) { _ in
            Task {
                if let userID = UserDefaults.standard.string(forKey: "userID") {
                    try await vm.loadAll(userId: userID)
                } else {
                    print("userID not found")
                }
            }
        }
        .onAppear() {
            Task {
                if let userID = UserDefaults.standard.string(forKey: "userID") {
                    try await vm.loadAll(userId: userID)
                } else {
                    print("userID not found")
                }
            }
        }
        .safeAreaPadding()
    }
}

#Preview {
    AgendaView(mainTabSelection: .constant(0), isAuthenticated: .constant(false))
}
