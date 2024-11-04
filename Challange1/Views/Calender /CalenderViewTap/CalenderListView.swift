//
//  TaskListView.swift
//  project2
//
//  Created by sumaiya on 24/10/2567 BE.
//


import SwiftUI
import SwiftData

struct CalenderListView: View {

    @Binding var date: Date
    @ObservedObject var agendaViewModel: AgendaViewModel
    @ObservedObject var addPostVM: AddPostViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading ,spacing: 16) {
                ScrollView{
                    ForEach(agendaViewModel.AllPostsAndEventsInDate?.indices ?? 0..<0, id: \.self) { index in
                        CalenderItemView(item: agendaViewModel.AllPostsAndEventsInDate?[index], vm: agendaViewModel, addPostVM: addPostVM)
                        
                    }
                }
            }
            .padding(.top, 20)
        }
        .padding(.top,40)
    }
}


