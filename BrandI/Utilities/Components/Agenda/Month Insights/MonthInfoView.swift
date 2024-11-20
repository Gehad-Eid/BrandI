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
                ZStack(alignment: .top){
                    ItemScrollView(items: Events, type: type)
                        .padding(.top, 10)
                    
                    Capsule()
                        .fill(Color.secondary)
                        .frame(width: 70, height: 5)
                        .padding(.top, 10)
                }
            }
            .sheet(isPresented: $showPostsScreen) {
                ZStack(alignment: .top){
                    ItemScrollView(items: Posts, type: type)
                        .padding(.top, 10)
                    
                    Capsule()
                        .fill(Color.secondary)
                        .frame(width: 70, height: 5)
                        .padding(.top, 10)
                }
            }
            // .sheet(isPresented: $showDraftssScreen) {
            //            ZStack(alignment: .top){
            //                ItemScrollView(items: Drafts, type: type)
            //            .padding(.top, 10)
            //        
            //        Capsule()
            //            .fill(Color.secondary)
            //            .frame(width: 70, height: 5)
            //            .padding(.top, 10)
            //    }
            // }
        }
        .padding(.vertical)
    }
}
