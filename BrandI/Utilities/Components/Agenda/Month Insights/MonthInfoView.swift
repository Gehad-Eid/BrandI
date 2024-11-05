//
//  MonthInfoView.swift
//  Challange1
//
//  Created by Gehad Eid on 04/11/2024.
//


import SwiftUI

struct MonthInfoView: View {
    let EventsCount: Int
    let PostsCount: Int
    let DraftsCount: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("This Month")
                .font(.title3)
                .fontWeight(.bold)
            
            HStack(spacing: 15) {
                MonthInfo(iconName: "calendar", count: EventsCount, title: "Events")
                MonthInfo(iconName: "document.fill", count: PostsCount, title: "Posts")
                MonthInfo(iconName: "pencil", count: DraftsCount, title: "Drafts")
            }
        }
        .padding(.vertical)
    }
}
