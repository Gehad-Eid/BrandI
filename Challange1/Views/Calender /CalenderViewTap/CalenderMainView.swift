//
//  TaskView.swift
//  project2
//
//  Created by sumaiya on 24/10/2567 BE.
//


import SwiftUI
import SwiftData

struct CalenderMainView: View {
    @StateObject var calenerviewModel = CalenderViewModel()
    @State private var createNewTask: Bool = false
    @State var currentDate: Date = .init()
        
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    WeeklyScrollView(calenerviewModel: calenerviewModel)
                        .frame(height: 89)
                        .padding(.top,40)
                   
                   
                    CalenderListView(date: $calenerviewModel.currentDate)
            
                    .scrollIndicators(.hidden)
                    .padding(.top,40)
                    
                }
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        HStack {
                            Text(self.calenerviewModel.currentDate.formatted(.dateTime.month(.wide)))
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text(self.calenerviewModel.currentDate.formatted(.dateTime.year()))
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
                                CalenderSheetView()
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
        CalenderMainView()
            .modelContainer(for: Task1.self)
    }
}
