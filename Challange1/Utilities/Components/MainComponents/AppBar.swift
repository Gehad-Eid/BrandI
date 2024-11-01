//
//  AppBar.swift
//  Challange1
//
//  Created by sumaiya on 21/10/2567 BE.
//

import SwiftUI

struct AppBar: View {
    let EventsCount: Int?
    let PostsCount: Int?
    let DraftsCount: Int?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                EventInfoView(
                    iconName: "Calender",
                    count: EventsCount ?? 0,
                    title: "Events",
                    isSystemImage: false,
                    destination: AnyView(AgendaView())
                )
                
                EventInfoView(
                    iconName: "document.fill",
                    count: PostsCount ?? 0,
                    title: "Posts",
                    isSystemImage: true,
                    destination: AnyView(AgendaView())
                )
                
                EventInfoView(
                    iconName: "pencil",
                    count: DraftsCount ?? 0,
                    title: "Drafts",
                    isSystemImage: true,
                    destination: AnyView(AgendaView())
                )
            }
            .padding(.top,10)
        }
    }
}

#Preview {
    AppBar(EventsCount: 2, PostsCount: 3, DraftsCount: 4)
}
