//
//  UpcomingDayView.swift
//  Challange1
//
//  Created by Gehad Eid on 04/11/2024.
//


import SwiftUI

struct UpcomingDayView: View {
    @EnvironmentObject var calenerviewModel: CalenderViewModel
    @EnvironmentObject var vm: AgendaViewModel
    
    @Binding var mainTabSelection: Int
    
    let counts: (postCount: Int, eventCount: Int, date: Date)
    let day: String
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 5) {
                HStack (alignment: .center){
                    Text("Upcoming in \(day) days")
                        .fontWeight(.bold)
                        .font(.system(size: 15))
                        .bold()
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    //TODO: Edit formatt
                    Text(DateFormatter.localizedString(from: counts.date, dateStyle: .medium, timeStyle: .none))
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(Color.white)
                }
                .padding(.top, 3)
                .padding(.bottom ,2)
                
                HStack {
                    HStack {
                        Image(systemName: "document.fill")
                            .resizable()
                            .foregroundColor(Color.white)
                            .frame(width: 13, height: 13)
                        
                        Text("\(counts.postCount) Posts")
                            .fontWeight(.medium)
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                    }
                    
                    Text(".")
                        .foregroundColor(Color.white)
                        .frame(width: 15, height: 15)
                    
                    HStack {
                        Image(systemName: "calendar")
                            .resizable()
                            .foregroundColor(Color.white)
                            .frame(width: 13, height: 13)
                        
                        Text("\(counts.eventCount) Events")
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
                .background(
                    RoundedRectangle(cornerRadius: 9)
                        .fill(Color.white.opacity(0.3))
                )
            }
            .padding(.horizontal)
           
        }
        .frame(height: 80, alignment: .leading)
        .background(Color("BabyBlue"))
        .cornerRadius(18)
        .padding(.horizontal,5)
        .onTapGesture {
            mainTabSelection = 1 // Switch to Calendar tab in MainTabView
            calenerviewModel.currentDateFromAgenda = counts.date
        }
    }
}
