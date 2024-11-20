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

    @State var showEventsScreen = false
    @State var showPostsScreen = false
    @State var showDraftssScreen = false
    @State var type = ""
//    @State var items: [Any] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("For this Month")
            //                .font(.title3)
                .font(.headline)
                .fontWeight(.bold)
            
            HStack(spacing: 15) {
                //                Spacer()
                MonthInfo(iconName: "calendar", count: Events.count, title: "Events")
                    .onTapGesture(){
                        type = "events"
//                        items = Events
                        showEventsScreen = true
                    }
                //                Spacer()
                MonthInfo(iconName: "document.fill", count: Posts.count, title: "Posts")
                    .onTapGesture(){
                        type = "posts"
//                        items = Posts
                        showPostsScreen = true
                    }
                //                Spacer()
//                MonthInfo(iconName: "pencil", count: Drafts.count, title: "Drafts")
//                    .onTapGesture(){
//                        type = "drafts"
////                        items = Drafts
//                        showDraftssScreen = true
//                    }
                //                Spacer()
            }
            .sheet(isPresented: $showEventsScreen) {
                VStack {
                    
                    ItemScrollView(items: Events, type: type)
                }
            }
            .sheet(isPresented: $showPostsScreen) {
                ItemScrollView(items: Posts, type: type)
            }
//            .sheet(isPresented: $showDraftssScreen) {
//                ItemScrollView(items: Drafts, type: type)
//            }
        }
        .padding(.vertical)
    }
}
