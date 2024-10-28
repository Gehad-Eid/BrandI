//
//  WeeklyScrollView.swift
//  project2
//
//  Created by sumaiya on 25/10/2567 BE.
//


import SwiftUI

struct WeeklyScrollView: View {
    @ObservedObject var viewModel = TaskViewModel()

    var body: some View {
        VStack {
            Divider()
            HStack {
                Button(action: {
                    viewModel.previousMonth()
                }) {
                    Text("Previous")
                        .foregroundColor(.babyBlue)
                }
                Spacer()
                Button(action: {
                    viewModel.nextMonth()
                }) {
                    Text("Next ")
                        .foregroundColor(.babyBlue)
                }
            }
            .padding(.horizontal)
           
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.currentMonthDates, id: \.self) { date in
                        VStack(spacing: 10) {
                            // Day abbreviation (e.g., Sat)
                            Text(viewModel.dateToString(date: date, format: "E"))
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            
                            // Date (e.g., 28)
                            Text(viewModel.dateToString(date: date, format: "dd"))
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                                .foregroundColor(viewModel.isToday(date: date) ? .white : .black) // Change text color based on today
                                .padding(8) // Padding around the date number
                                .background(
                                    ZStack {
                                        if viewModel.isToday(date: date) {
                                            Circle()
                                                .fill(Color.blue) // Change to the desired highlight color
                                                .frame(width: 35, height: 35) // Increased size for better visibility
                                        }
                                    }
                                )
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.babyBlue)
                        )
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                viewModel.currentDate = date
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}



#Preview {
    WeeklyScrollView()
}
