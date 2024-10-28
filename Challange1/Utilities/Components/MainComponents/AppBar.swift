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
        VStack(alignment: .leading){
            // Agenda
            HStack() {
                EventInfoView(iconName: "Calender", count: EventsCount ?? 0, title: "Events", isSystemImage: false, destination: AnyView(AgendaView()))
                EventInfoView(iconName: "document.fill", count: PostsCount ?? 0, title: "Posts", isSystemImage: true, destination: AnyView(AgendaView()))
                EventInfoView(iconName: "pencil", count: DraftsCount ?? 0, title: "Drafts", isSystemImage: true, destination: AnyView(AgendaView()))
                
            }.padding(.top,10)
        }
    }
}

#Preview {
    AppBar(EventsCount: 2, PostsCount: 3, DraftsCount: 4)
}

//Components
import SwiftUI

struct EventInfoView: View {
    var iconName: String
    var count: Int
    var title: String
    var isSystemImage: Bool
    var destination: AnyView

    var body: some View {
        VStack(alignment: .leading,spacing: 3) {
            HStack(alignment: .firstTextBaseline) {
              
                NavigationLink(destination: destination) {
                    if isSystemImage {
                        Image(systemName: iconName)
                            .foregroundColor(Color("BabyBlue"))
                            .frame(width: 20, height: 20)
                    } else {
                        Image(iconName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                }
               
                
                Text(count.description)
            }
            .padding(.top, 10)
            Text(title)
                .font(.system(size: 13, weight: .regular))
        }
        .padding(.horizontal, 5)
    }
}

#Preview {
   
    EventInfoView(iconName: "note", count: 2, title: "Events", isSystemImage: true, destination: AnyView(Text("Events Page")))
    EventInfoView(iconName: "document.fill", count: 3, title: "Posts", isSystemImage: true, destination: AnyView(Text("Posts Page")))
    EventInfoView(iconName: "pencil", count: 4, title: "Drafts", isSystemImage: true, destination: AnyView(Text("Drafts Page")))
}
