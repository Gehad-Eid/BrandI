//
//  EventView.swift
//  Challange1
//
//  Created by sumaiya on 21/10/2567 BE.
//

import SwiftUI

struct EventView: View {
    @State private var title: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var isStartDatePickerPresented = false
    @State private var isEndDatePickerPresented = false
    @State private var startDateSelectedColor: Color = .clear
    @State private var endDateSelectedColor: Color = .clear
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                // Title TextField
                TextField("Title", text: $title)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.clear)
                    .font(.title2)
                
                Divider()
                    .background(Color.gray)
                    .padding(.horizontal)
                    .padding(.bottom, 60)

                // Start Date Button
                VStack(alignment: .leading) {
                    Text("Starts in")
                        .font(.system(size: 18, weight: .semibold))
                    
                    Text(dateToString(startDate))
                        .frame(width: 150, height: 40)
                        .foregroundColor(startDateSelectedColor == Color("BabyBlue") ? .white : .gray) // Text color based on selection
                        .background(startDateSelectedColor) // Use selected color for the background
                        .cornerRadius(8)
                        .overlay(
                            // Conditionally include the stroke based on selection
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(startDateSelectedColor == Color("BabyBlue") ? Color.clear : Color.gray, lineWidth: 1)
                        )
                        .onTapGesture {
                            isStartDatePickerPresented.toggle()
                        }

                    if isStartDatePickerPresented {
                        VStack {
                            DatePicker(
                                "Start in",
                                selection: $startDate,
                                displayedComponents: .date
                            )
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .onChange(of: startDate) { newValue in
                              
                                startDateSelectedColor = Color("BabyBlue")
                               
                                isStartDatePickerPresented = false
                            }
                        }
                        .padding(.top, 5)
                    }
                }
                .padding(.bottom, 20)

                // End Date Button
                VStack(alignment: .leading) {
                    Text("Ends in")
                        .font(.system(size: 18, weight: .semibold))
                    
                    Text(dateToString(endDate))
                        .frame(width: 150, height: 40)
                        .foregroundColor(endDateSelectedColor == Color("BabyBlue") ? .white : .gray) // Text color based on selection
                        .background(endDateSelectedColor) // Use selected color for the background
                        .cornerRadius(8)
                        .overlay(
                            // Conditionally include the stroke based on selection
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(endDateSelectedColor == Color("BabyBlue") ? Color.clear : Color.gray, lineWidth: 1)
                        )
                        .onTapGesture {
                            isEndDatePickerPresented.toggle()
                        }

                    if isEndDatePickerPresented {
                        VStack {
                            DatePicker(
                                "Select End Date",
                                selection: $endDate,
                                displayedComponents: .date
                            )
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .onChange(of: endDate) { newValue in
                                // Change button color to Baby Blue when a date is selected
                                endDateSelectedColor = Color("BabyBlue")
                                // Dismiss the date picker
                                isEndDatePickerPresented = false
                            }

                           
                        }
                        .padding(.top, 5)
                    }
                }
                .padding(.bottom, 20)

                Spacer()
            }
            .padding()
            .navigationTitle("Add Post")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        // Dismiss the view
                    }
                    .foregroundColor(Color.black)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Next") {
                        // Handle next action
                    }
                    .foregroundColor(Color("BabyBlue"))
                }
            }
        }
    }
}

// Function to format the date as "Jun 10, 2024"
private func dateToString(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy"
    return dateFormatter.string(from: date)
}

#Preview {
    EventView()
}
