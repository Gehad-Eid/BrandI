//
//  AppBar.swift
//  Challange1
//
//  Created by sumaiya on 21/10/2567 BE.
//


import SwiftUI

struct AppBar: View {
    var body: some View {
        VStack(alignment: .leading){
           
            
            // Agenda
            HStack(){
                EventInfoView(iconName: "Calender", count: "2", title: "Events", isSystemImage: false, destination: AnyView(AgendaView()))
                EventInfoView(iconName: "document.fill", count: "3", title: "Posts", isSystemImage: true, destination: AnyView(AgendaView()))
                EventInfoView(iconName: "pencil", count: "1", title: "Drafts", isSystemImage: true, destination: AnyView(AgendaView()))
                
            }.padding(.top,10)
        }
    }
}

#Preview {
    AppBar()
}

//Components
import SwiftUI

struct EventInfoView: View {
    var iconName: String
    var count: String
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
               
                
                Text(count)
            }
            .padding(.top, 10)
            Text(title)
                .font(.system(size: 13, weight: .regular))
        }
        .padding(.horizontal, 5)
    }
}

#Preview {
   
    EventInfoView(iconName: "note", count: "2", title: "Events", isSystemImage: true, destination: AnyView(Text("Events Page")))
    EventInfoView(iconName: "document.fill", count: "3", title: "Posts", isSystemImage: true, destination: AnyView(Text("Posts Page")))
    EventInfoView(iconName: "pencil", count: "1", title: "Drafts", isSystemImage: true, destination: AnyView(Text("Drafts Page")))
}
