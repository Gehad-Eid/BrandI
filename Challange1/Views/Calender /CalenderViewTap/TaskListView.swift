//
//  TaskListView.swift
//  project2
//
//  Created by sumaiya on 24/10/2567 BE.
//


import SwiftUI
import SwiftData

struct TaskListView: View {
    
    @State private var posts: [[String: Any]] = [
        ["title": "Post Title 1", "imageName": "document.fill", "platformList": ["document.fill", "document.fill", "document.fill"]],
        ["title": "Post Title 2", "imageName": "document.fill", "platformList": ["document.fill", "document.fill", "document.fill"]],
        ["title": "Post Title 3", "imageName": "document.fill", "platformList": ["document.fill", "document.fill", "document.fill"]]
    ]
    
    @Binding var date: Date
    @Query private var tasks: [Task1]
    
    init(date: Binding<Date>) {
        self._date = date
        
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: date.wrappedValue)
        let endOfDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        let predicate = #Predicate<Task1> {
            return $0.date >= startDate && $0.date < endOfDate
        }
        
        let sortDescriptor = [
            SortDescriptor(\Task1.date, order: .forward)
        ]
        self._tasks = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading ,spacing: 44) {
                ForEach(tasks) { task in
                    TaskItemView(task: task,platformList: ["","",""])
                        .background(alignment: .leading) {
                            if tasks.last?.id != task.id {
                               
                            }
                        }
                }
            }
            .padding(.top, 20)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    TaskListView(date: .constant(Date()))
        .modelContainer(for: Task1.self)
}
