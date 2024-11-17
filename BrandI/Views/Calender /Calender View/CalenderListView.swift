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
    
    @State private var activeSwipedItem: String? = nil
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading ,spacing: 16) {
                ForEach(agendaViewModel.AllPostsAndEventsInDate?.indices ?? 0..<0, id: \.self) { index in
                    CalenderItemView(
                        item: agendaViewModel.AllPostsAndEventsInDate?[index],
                        itemBinding: $item,
                        showDeletePopup: $showDeletePopup,
                        activeSwipedItem: $activeSwipedItem
                    )
                }
            }
            .padding(.top, 20)
        }
        .padding(.top,40)
    }
}


