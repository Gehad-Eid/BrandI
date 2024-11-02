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
    
    @StateObject var vm = AgendaViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                
                ScrollView { // ?
                    VStack(alignment: .leading) {
                        HStack(alignment: .center) {
                            Text("Agenda")
                                .font(.system(size: 40, weight: .bold))
                            Spacer()
                            
                            Button(action: {
                                showingAddPostView.toggle()
                            }) {
                                Text("+")
                                    .font(.system(size: 20, weight: .regular))
                                    .foregroundColor(Color("Background"))
                                    .frame(width: 30, height: 30)
                                    .background(Color("BabyBlue"))
                                    .cornerRadius(6.0)
                                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 4)
                                    .multilineTextAlignment(.center)
                            }
                            .sheet(isPresented: $showingAddPostView) {
                                CreatePostView(post: nil)
                            }
                        }
                        
                        SiriTipView(
                            intent: AddPostIntent(),
                            isVisible: $tipIsShown
                        )
                        
                        AppBar(EventsCount: vm.thisMonthEvents?.count, PostsCount: vm.thisMonthPosts?.count, DraftsCount: vm.thisMonthDraftPosts?.count)
                            .padding(.top, -15)
                        
                        UpcomingSection(vm: vm)
                            .padding(.top, 10)
                        
                        CardViewSection(vm: vm)
                            .padding(.top, 5)
                    }
                    .padding(.horizontal, 20)
                }
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
    }
}

#Preview {
    AgendaView()
}
