//
//  EventInfoView.swift
//  Challange1
//
//  Created by Gehad Eid on 01/11/2024.
//


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
