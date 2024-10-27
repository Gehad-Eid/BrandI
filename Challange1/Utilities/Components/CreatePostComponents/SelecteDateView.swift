//
//  SelecteDateView.swift
//  Challange1
//
//  Created by Gehad Eid on 26/10/2024.
//

import SwiftUI

struct SelecteDateView: View {
    @Binding var selectedDate: Date
    @Binding var isEditingEnabled: Bool
    @State private var isDatePickerPresented = false

    var body: some View {
        Text("Select Date")
            .font(.system(size: 18, weight: .semibold))
        
        Text(dateToString(selectedDate))
            .frame(width: 150, height: 40)
            .foregroundColor(.gray)
            .background(Color.clear)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .onTapGesture {
                if isEditingEnabled {
                    isDatePickerPresented = true
                }
            }
            .sheet(isPresented: $isDatePickerPresented) {
                VStack {
                    DatePicker(
                        "Select a date",
                        selection: Binding(
                            get: { Date() },
                            set: { selectedDate = $0 }
                        ),
                        displayedComponents: .date
                    )
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .labelsHidden()
                    
                    Button("Done") {
                        isDatePickerPresented = false
                    }
                    .padding()
                }
                .padding()
            }
    }
    
    // Format date to string
    private func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
