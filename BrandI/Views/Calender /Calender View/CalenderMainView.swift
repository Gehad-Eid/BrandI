//
//  TaskView.swift
//  project2
//
//  Created by sumaiya on 24/10/2567 BE.
//

import SwiftUI
import SwiftData

struct CalenderMainView: View {
    @EnvironmentObject var vm: AgendaViewModel
    @EnvironmentObject var calenerviewModel: CalenderViewModel
    
    @ObservedObject var addPostVM = AddPostViewModel()
    
    @Binding var isAuthenticated: Bool
    
    @State var currentDate: Date = .init()
    @State private var showingAddPostView = false
    @State private var showDeletePopup = false
    @State private var showSignInSheet = false
    @State private var showCalendarSheet = false
    @State var item: Any? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
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
                
                // Delete confirmation popup overlay
                if showDeletePopup {
                    DeleteAlert(addPostVM: addPostVM, showDeletePopup: $showDeletePopup, item: item as Any)
                        .zIndex(1)
                }
                
                VStack(alignment: .leading) {
                    WeeklyScrollView()
                        .frame(height: 89)
                        .padding(.top,40)
                    
                    if isAuthenticated {
                        CalenderListView(showDeletePopup: $showDeletePopup, item: $item)
                            .scrollIndicators(.hidden)
                    } else {
                        VStack {
                            EmptyView()
                            Spacer()
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        HStack {
                            Text(self.calenerviewModel.currentDate.formatted(.dateTime.month(.wide)))
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            Text(self.calenerviewModel.currentDate.formatted(.dateTime.year()))
                                .foregroundColor(Color("Text"))
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }
                    }
                    // Calendar Icon Toolbar Item
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            showCalendarSheet = true
                        }, label: {
                            Image(systemName: "calendar")
                                .foregroundColor(.babyBlue)
                        })
                        .sheet(isPresented: $showCalendarSheet) {
                            CalendarView(calendar: .current,isAuthenticated: $isAuthenticated, currentDate: $currentDate, highlightedDates: vm.extractDates(from: vm.AllPostsAndEvents ?? [])
                            )
                        }
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            if isAuthenticated {
                                showingAddPostView.toggle()
                            } else {
                                showSignInSheet = true
                            }
                        }, label: {
                            Image(systemName: "plus")
                                .foregroundColor(.babyBlue)
                        })
                        .sheet(isPresented: $showingAddPostView) {
                            AddPostView()
                        }
                        .sheet(isPresented: $showSignInSheet) {
                            AuthContainerView(isAuthenticated: $isAuthenticated, showSignInSheet: $showSignInSheet)
                        }
                    }
                }
            }
        }
        .onAppear() {
            Task {
                if let userID = UserDefaults.standard.string(forKey: "userID") {
                    try await vm.loadPosts(userId: userID)
                    try await vm.loadEvents(userId: userID)
                    
                    vm.getAll()
                    vm.getAllInDay(date: calenerviewModel.currentDate)
                    
                } else {
                    print("Failed to retrieve posts: userID not found")
                }
            }
        }
        .onChange(of: vm.updateUITrigger) { _ in
            Task {
                if let userID = UserDefaults.standard.string(forKey: "userID") {
                    try await vm.loadPosts(userId: userID)
                    try await vm.loadEvents(userId: userID)
                    
                    vm.getAll()
                    vm.getAllInDay(date: calenerviewModel.currentDate)
                } else {
                    print("userID not found")
                }
            }
        }
        .onChange(of: addPostVM.updateUITrigger) { _ in
            Task {
                if let userID = UserDefaults.standard.string(forKey: "userID") {
                    try await vm.loadPosts(userId: userID)
                    try await vm.loadEvents(userId: userID)
                    
                    vm.getAll()
                    vm.getAllInDay(date: calenerviewModel.currentDate)
                } else {
                    print("userID not found")
                }
            }
        }
    }
}
