//
//  MonthInfoView.swift
//  Challange1
//
//  Created by Gehad Eid on 04/11/2024.
//


import SwiftUI

struct MonthInfoView: View {
    let Events: [Event]
    let Posts: [Post]
    let Drafts: [Post]

    @State var showScreen = false
    @State var type = ""
    @State var items: [Any] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("For this Month")
            //                .font(.title3)
                .font(.headline)
                .fontWeight(.bold)
            
            HStack/*(spacing: 15)*/ {
                //                Spacer()
                MonthInfo(iconName: "calendar", count: Events.count, title: "Events")
                    .onTapGesture(){
                        type = "events"
                        items = Events
                        showScreen = true
                    }
                //                Spacer()
                MonthInfo(iconName: "document.fill", count: Posts.count, title: "Posts")
                    .onTapGesture(){
                        type = "posts"
                        items = Posts
                        showScreen = true
                    }
                //                Spacer()
                MonthInfo(iconName: "pencil", count: Drafts.count, title: "Drafts")
                    .onTapGesture(){
                        type = "drafts"
                        items = Drafts
                        showScreen = true
                    }
                //                Spacer()
            }
            .sheet(isPresented: $showScreen) {
                ItemScrollView(items: items, type: type)
            }
        }
        .padding(.vertical)
    }
}
