//
//  TaskView.swift
//  project2
//
//  Created by sumaiya on 24/10/2567 BE.
//


import SwiftUI
import SwiftData

struct CalenderMainView: View {
//    @Environment var addPostVM: AddPostViewModel
    @EnvironmentObject var vm: AgendaViewModel
    
    @Binding var isAuthenticated: Bool
    
    @State var currentDate: Date = .init()
    @State private var showingAddPostView = false
    @State private var showDeletePopup = false
    @State private var showSignInSheet = false
    
    @ObservedObject var calenerviewModel: CalenderViewModel
//    @StateObject var vm = AgendaViewModel()
    
    @State var item: Any? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                // Delete confirmation popup overlay
                if showDeletePopup {
                    DeleteAlert(/*addPostVM: addPostVM,*/ showDeletePopup: $showDeletePopup, item: item as Any)
                        .zIndex(1)
                }
                
                VStack(alignment: .leading) {
                    WeeklyScrollView(calenerviewModel: calenerviewModel/*, agendaViewModel: vm*/)
                        .frame(height: 89)
                        .padding(.top,40)
                    
                    if isAuthenticated {
                        CalenderListView(showDeletePopup: $showDeletePopup, item: $item/*, agendaViewModel: vm, addPostVM: addPostVM*/)
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
                            CreatePostView(post: nil)
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
    }
}
