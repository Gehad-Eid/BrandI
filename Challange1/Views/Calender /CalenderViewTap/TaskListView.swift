//
//  TaskListView.swift
//  project2
//
//  Created by sumaiya on 24/10/2567 BE.
//


import SwiftUI
import SwiftData

struct TaskListView: View {
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
            VStack(alignment: .leading) {
                ForEach(tasks) { task in
                    TaskItemView(task: task)
                        .background(alignment: .leading) {
                            if tasks.last?.id != task.id {
                                Rectangle()
                                    .frame(width: 1)
                                    .foregroundColor(Color.black)
                                    .offset(x: 35, y: 38)
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
