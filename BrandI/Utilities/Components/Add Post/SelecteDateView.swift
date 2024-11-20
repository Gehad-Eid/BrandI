//
//  SelecteDateView.swift
//  Challange1
//
//  Created by Gehad Eid on 26/10/2024.
//

import SwiftUI

struct SelecteDateView: View {
    @Environment(\.presentationMode) var presentationMode
     let title: String
    @Binding var selectedDate: Date
    @Binding var selectedTab: String
    @State private var isDatePickerPresented = false
    @State private var isDateSelected = false
    // Helper function to format the date
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy" // Custom format for "Jun 10, 2024"
        return formatter.string(from: date)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if selectedTab == "Add New Post" {
                Text("Select Date")
                    .font(.headline.weight(.medium))
            }
            
            HStack{
                if selectedTab == "Add New Event" {
                    Text(title)
                        .font(.headline.weight(.regular))
                    Spacer()
                }
                
                // Date Picker
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .onChange(of: selectedDate) { _ in
                        isDateSelected = true
                       
                        
                    }
                    .labelsHidden()
                       .accentColor(Color("BabyBlue"))
                       .background(Color.clear)
                       .foregroundColor(Color.gray)
                       .overlay(
                           RoundedRectangle(cornerRadius: 10)
                               .stroke(Color.gray, lineWidth: 2)
                       )
                       .cornerRadius(10)
                
                    .overlay {
                        ZStack {
                            if isDateSelected {
                                Color("BabyBlue")
                                    .cornerRadius(10)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                Text(formattedDate(selectedDate))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .onTapGesture {
                                        isDatePickerPresented = true // Show the DatePicker in a sheet
                                    }
                            } else {
                                
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .allowsHitTesting(false)
                        .presentationCompactAdaptation((.popover))
                    }

                if selectedTab == "Add New Post" {
                    Spacer()
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
        }
        .padding(.top, 10)
    }
}


