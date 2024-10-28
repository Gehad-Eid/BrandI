//
//  MonthView.swift
//  project2
//
//  Created by sumaiya on 25/10/2567 BE.
//

import SwiftUI



struct MonthGridView: View {
    @ObservedObject var viewModel = TaskViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Text("Year: \(Calendar.current.component(.year, from: viewModel.currentDate))")
                .font(.title)
                .padding()

            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.allMonths.indices, id: \.self) { index in
                    MonthView(monthDates: viewModel.allMonths[index])
                }
            }
            .padding()
        }
    }
}

struct MonthView: View {
    var monthDates: [Date]
    
    var body: some View {
        VStack {
            Text(dateToString(date: monthDates.first ?? Date(), format: "MMMM"))
                .font(.headline)
                .padding()

            ForEach(monthDates, id: \.self) { date in
                Text("\(Calendar.current.component(.day, from: date))")
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .background(isToday(date) ? Color.blue.opacity(0.3) : Color.clear)
                    .cornerRadius(5)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    
    func isToday(_ date: Date) -> Bool {
        Calendar.current.isDateInToday(date)
    }

    func dateToString(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}



#Preview {
    MonthGridView()
}

//Calendar Views need to be fixed 
