//
//  SelecteDateView.swift
//  Challange1
//
//  Created by Gehad Eid on 26/10/2024.
//

import SwiftUI

struct SelecteDateView: View {
    @Binding var selectedDate: Date
    @Binding var selectedTab: String
    @State private var isDatePickerPresented = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if selectedTab == "Add New Post" {
                Text("Select Date")
                    .font(.headline.weight(.regular))
            }
            
            HStack{
                if selectedTab == "Add New Event" {
                    Text("Select Date")
                        .font(.headline.weight(.regular))
                    Spacer()
                }
                
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .frame(width: 140, height: 40)
                    .foregroundColor(.white)
                    .background(Color("BabyBlue"))
                    .cornerRadius(10)
                    .datePickerStyle(.compact)
                    .labelsHidden()
                
                if selectedTab == "Add New Post" {
                    Spacer()
                }
            }
            .padding()
            .background(Color("graybackground"))
            .cornerRadius(15)
        }
        .padding(.top, 10)
    }
}
