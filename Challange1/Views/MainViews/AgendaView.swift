//
//  MainView.swift
//  Challange1
//
//  Created by sumaiya on 21/10/2567 BE.
//

import SwiftUI

struct AgendaView: View {
    @State private var isButtonOn = true
    @State private var showingAddPostView = false
    
    @StateObject var vm = AgendaViewModel()
        
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        Text("Agenda")
                            .font(.system(size: 40, weight: .bold))
                        Spacer()
                        
                        // NavigationLink for button click
                        Button(action: {
                            showingAddPostView.toggle()
                        }) {
                            Text("+")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                .background(Color("BabyBlue"))
                                .cornerRadius(6.0)
                                .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 4) // Add shadow
                                .multilineTextAlignment(.center) // Center the text
                        }
                        .sheet(isPresented: $showingAddPostView) {
                            CreatePostView()
                        }
//                        NavigationLink(destination: CreatePostView()) {
//                            Text("+")
//                                .font(.system(size: 20, weight: .regular))
//                                .foregroundColor(.white)
//                                .frame(width: 30, height: 30)
//                                .background(Color("BabyBlue"))
//                                .cornerRadius(6.0)
//                                .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 4) // Add shadow
//                                .multilineTextAlignment(.center) // Center the text
//                        }
                        
                    }
                    
                    AppBar(EventsCount: vm.events?.count, PostsCount: vm.posts?.count, DraftsCount: vm.draftPosts?.count)
                        .padding(.top, -15)
                    
                    UpcomingSection()
                        .padding(.top, 10)
                  
                    CardViewSection(postDataArray: vm.posts ?? [])
                        .padding(.top, 5)
                }
                .padding(.horizontal, 20)
            }
        }
        .onAppear() {
            Task {
                if let userID = UserDefaults.standard.string(forKey: "userID") {
                    try await vm.loadPosts(userId: userID)
                    try await vm.loadEvents(userId: userID)
                    vm.loadDraftPosts()
                }
            }
        }
    }
}

#Preview {
    AgendaView()
}
