//
//  EventInfoView.swift
//  Challange1
//
//  Created by Gehad Eid on 04/11/2024.
//


import SwiftUI

struct MonthInfo: View {
    var iconName: String
    var count: Int
    var title: String
    //    var destination: AnyView
    
    var body: some View {
        //  NavigationLink(destination: destination) {
        VStack (alignment: .leading){
            HStack (alignment:.bottom){
                Image(systemName: iconName)
                    .resizable()
                    .foregroundColor(Color("BabyBlue"))
                    .frame(width: 20, height: 20)
                
                Text(count.description)
                    .font(.system(size: 13, weight: .regular))
            }
            Text(title)
                .font(.system(size: 13, weight: .regular))
        }
        //    }
    }
}
#Preview {
    MonthInfo(iconName: "calendar", count: 10, title: "Events")
}
