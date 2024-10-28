//
//  TaskView.swift
//  project2
//
//  Created by sumaiya on 24/10/2567 BE.
//


import SwiftUI
import SwiftData

struct TaskView: View {
    @StateObject var viewModel = TaskViewModel()
    @State private var createNewTask: Bool = false
    @State var currentDate: Date = .init()
        
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    Text(self.viewModel.currentDate.formatted(.dateTime.year().month(.wide).day().weekday(.wide)))
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.gray)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    WeeklyScrollView(viewModel: viewModel)
                        .frame(height: 89)
                        .padding(.top,40)
                    
                    ScrollView(.vertical) {
                        TaskListView(date: $viewModel.currentDate)
                    }
                    .scrollIndicators(.hidden)
                    .padding(.top,40)
                    //it will Goes to TaskList View
                    SinglePostInCalendar()
                }
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        HStack {
                            Text(self.viewModel.currentDate.formatted(.dateTime.month(.wide)))
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text(self.viewModel.currentDate.formatted(.dateTime.year()))
                                .foregroundColor(Color.black)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            createNewTask = true
                        }, label: {
                            Image(systemName: "plus")
                                .foregroundColor(.primary)
                        })
                            .sheet(isPresented: $createNewTask) {
                                TaskSheetView()
                                    .presentationDetents([.height(380)])
                                    .presentationBackground(.thinMaterial)
                            }
                    }
                }
            }
            .preferredColorScheme(.light)
        }
    }
}

#Preview {
    NavigationView {
        TaskView()
            .modelContainer(for: Task.self)
    }
}
