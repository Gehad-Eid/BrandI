//
//  UpcomingDayView.swift
//  Challange1
//
//  Created by Gehad Eid on 04/11/2024.
//


import SwiftUI

struct UpcomingDayView: View {
    @ObservedObject var calenerviewModel: CalenderViewModel
    @Binding var mainTabSelection: Int
    
    let counts: (postCount: Int, eventCount: Int, Date: Date)
    let day: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("In \(day) days")
                .bold()
                .padding(.horizontal)
            
            HStack {
                HStack {
                    Image(systemName: "document.fill")
                        .resizable()
                        .foregroundColor(Color("BabyBlue"))
                        .frame(width: 13, height: 13)
                    
                    Text("\(counts.postCount) Posts")
                        .foregroundColor(Color("BabyBlue"))
                }
                
                Image(systemName: "dot.circle")
                    .resizable()
                    .foregroundColor(Color("BabyBlue"))
                    .frame(width: 13, height: 13)
                
                HStack {
                    Image(systemName: "calendar")
                        .resizable()
                        .foregroundColor(Color("BabyBlue"))
                        .frame(width: 13, height: 13)
                    
                    Text("\(counts.eventCount) Events")
                        .foregroundColor(Color("BabyBlue"))
                }
            }
            .padding(.horizontal)
        }
        .frame(width: 350, height: 80, alignment: .leading)
        .background(Color("BoxColor"))
        .cornerRadius(18)
        .padding(.horizontal)
        .onTapGesture {
            mainTabSelection = 1 // Switch to Calendar tab in MainTabView
            calenerviewModel.currentDate = counts.Date
        }
    }
}
