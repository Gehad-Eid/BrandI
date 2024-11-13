//
//  TaskListView.swift
//  project2
//
//  Created by sumaiya on 24/10/2567 BE.
//


import SwiftUI

struct CalenderListView: View {
    @EnvironmentObject var agendaViewModel: AgendaViewModel

    @Binding var showDeletePopup: Bool
    
    @Binding var item: Any?
//    @ObservedObject var agendaViewModel: AgendaViewModel
//    @Environment var addPostVM: AddPostViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading ,spacing: 16) {
                ForEach(agendaViewModel.AllPostsAndEventsInDate?.indices ?? 0..<0, id: \.self) { index in
                    CalenderItemView(item: agendaViewModel.AllPostsAndEventsInDate?[index], /*vm: agendaViewModel,*/ /*addPostVM: addPostVM,*/ itemBinding: $item, showDeletePopup: $showDeletePopup)
                }
            }
            .padding(.top, 20)
        }
        .padding(.top,40)
    }
}


