//
//  WeeklyScrollView.swift
//  project2
//
//  Created by sumaiya on 25/10/2567 BE.
//


import SwiftUI

struct WeeklyScrollView: View {
    @ObservedObject var calenerviewModel = CalenderViewModel()

    var body: some View {
        VStack {
           
           
            HStack {
                Button(action: {
                    calenerviewModel.previousMonth()
                }) {
                    Image(systemName:"chevron.backward")
                        .foregroundColor(.babyBlue)
                }
                Spacer()
                Button(action: {
                    calenerviewModel.nextMonth()
                }) {
                    Image(systemName:"chevron.right")
                        .foregroundColor(.babyBlue)
                }
            }
            .padding(.horizontal)
           
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(calenerviewModel.currentMonthDates, id: \.self) { date in
                        VStack(spacing: 10) {
                            // Day abbreviation (e.g., Sat)
                            Text(calenerviewModel.dateToString(date: date, format: "E"))
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            
                            // Date (e.g., 28)
                            Text(calenerviewModel.dateToString(date: date, format: "dd"))
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                                .foregroundColor(calenerviewModel.isToday(date: date) ? .white : .black)
                                .padding(2)
                                .background(
                                    ZStack {
                                        if calenerviewModel.isToday(date: date) {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color("BabyBlue"))
                                                .frame(width: 35, height: 35) 
                                        }
                                    }
                                )
                        }
                        .padding(.horizontal)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.clear)
                        )
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                calenerviewModel.currentDate = date
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                
        
            }
            Divider()
            Text(self.calenerviewModel.currentDate.formatted(.dateTime.year().month(.wide).day().weekday(.wide)))
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .padding(.horizontal)
            Divider()
                
        }
    }
}



#Preview {
    WeeklyScrollView()
}
