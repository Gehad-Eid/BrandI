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
                            .font(Font.system(size: 12))
                            .padding()
                            .background(Color("BabyBlue"))
                            .cornerRadius(8)
                            .transition(.move(edge: .top))
                            .animation(.easeInOut)
                            .frame(maxWidth: 290, minHeight: 50)
                    }
                    
                    Spacer()
                }
                .zIndex(100)
                
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading) {
                            // Header
                            HeaderView(showingAddPostView: $showingAddPostView, isAuthenticated: $isAuthenticated)
                                .padding(.bottom, tipIsShown ? 0 : -15)
                            
                            
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
                                MonthInfoView(Events: vm.thisMonthEvents ?? [], Posts: vm.thisMonthPosts ?? [], Drafts: vm.thisMonthDraftPosts ?? [])
                                
                                if let DraftsCount = vm.thisMonthDraftPosts?.count, DraftsCount != 0 {
                                    //Draft View
                                    DraftSection(items: vm.thisMonthDraftPosts ?? [])
                                }
                                
                                // Upcoming events and posts for the next week
                                if vm.upcomingItems?.isEmpty == false {
                                    UpcomingView(mainTabSelection: $mainTabSelection)
                                }
                                
                                // Yesterday, today, and tomorrow's Posts
                                UpcomingRecentPostsView(mainTabSelection: $mainTabSelection, isAuthenticated: $isAuthenticated)
                            }
                            else {
                                // Month details
                                MonthInfoView(Events: [], Posts: [], Drafts: [])
                                
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
