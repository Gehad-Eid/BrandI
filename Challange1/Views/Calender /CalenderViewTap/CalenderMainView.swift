//
//  TaskView.swift
//  project2
//
//  Created by sumaiya on 24/10/2567 BE.
//


import SwiftUI
import SwiftData

struct CalenderMainView: View {
    @State var currentDate: Date = .init()
    @State private var showingAddPostView = false
    
    @StateObject var calenerviewModel = CalenderViewModel()
    @StateObject var vm = AgendaViewModel()
    @StateObject var addPostVM = AddPostViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    WeeklyScrollView(calenerviewModel: calenerviewModel, agendaViewModel: vm)
                        .frame(height: 89)
                        .padding(.top,40)
                   
                   
                    CalenderListView(date: $calenerviewModel.currentDate, agendaViewModel: vm, addPostVM: addPostVM)
                    .scrollIndicators(.hidden)
                    
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
                        
                            showingAddPostView.toggle()
                        }, label: {
                            Image(systemName: "plus")
                                .foregroundColor(.babyBlue)
                        })
                            .sheet(isPresented: $showingAddPostView) {
                                CreatePostView(post: nil)
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
