//
//  SelecteDateView.swift
//  Challange1
//
//  Created by Gehad Eid on 26/10/2024.
//

import SwiftUI
//import SwiftUI
//
//struct SelecteDateView: View {
//    @Binding var selectedDate: Date
//    @Binding var isEditingEnabled: Bool
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Select Date")
//                .font(.headline)
//                .padding(.bottom, 4)
//
//            ZStack {
//                RoundedRectangle(cornerRadius: 12)
//                    .fill(Color(UIColor.systemGray5))
//                    .frame(height: 50)
//
//                DatePicker("", selection: $selectedDate, displayedComponents: .date)
//                    .frame(width: 150, height: 40)
//                    .foregroundColor(.gray)
//                    .background(Color.clear)
//                    .cornerRadius(8)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 8)
//                            .stroke(Color.gray, lineWidth: 1)
//                    )
//                    .datePickerStyle(.compact) // Compact style to keep it inline
//                    .labelsHidden() // Hides default label for a cleaner look
////                    .padding(.horizontal, 10)
////                    .background(
////                        RoundedRectangle(cornerRadius: 8)
////                            .stroke(Color.gray, lineWidth: 1)
////                            .padding(4)
////                    )
//                    .disabled(!isEditingEnabled) // Disable when isEditingEnabled is false
//            }
//            .padding(.horizontal)
//        }
//        .padding()
//    }
//}


struct SelecteDateView: View {
    @Binding var selectedDate: Date
    @Binding var isEditingEnabled: Bool
    @State private var isDatePickerPresented = false
    
    var body: some View {
        
        Text("Select Date")
            .font(.system(size: 18, weight: .medium))
        HStack{
            
            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                .frame(width: 140, height: 40)
                .foregroundColor(.white)
                .background(Color.clear)
                .cornerRadius(10)
                .datePickerStyle(.compact)
                .labelsHidden()
                .disabled(!isEditingEnabled)
                .padding(.leading, 10)
            
            Spacer()
            
        }.frame(width: 362, height: 49)
            .background(Color("graybackground"))
            .cornerRadius(18)
    }
}
         
//        Text(dateToString(selectedDate))
//            .frame(width: 150, height: 40)
//            .foregroundColor(.gray)
//            .background(Color.clear)
//            .cornerRadius(8)
//            .overlay(
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(Color.gray, lineWidth: 1)
//            )
//            .onTapGesture {
//                if isEditingEnabled {
//                    isDatePickerPresented = true
//                }
//            }
//            .sheet(isPresented: $isDatePickerPresented) {
//                VStack {
//                    DatePicker(
//                        "Select a date",
//                        selection: Binding(
//                            get: { Date() },
//                            set: { selectedDate = $0 }
//                        ),
//                        displayedComponents: .date
//                    )
//                    .datePickerStyle(GraphicalDatePickerStyle())
//                    .labelsHidden()
//                    
//                    Button("Done") {
//                        isDatePickerPresented = false
//                    }
//                    .padding()
//                }
//                .padding()
//            }
    //}
    
//    // Format date to string
//    private func dateToString(_ date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        return formatter.string(from: date)
//    }
//}


//DatePicker("", selection: $selectedDate, displayedComponents: .date)
//            .frame(width: 150, height: 40)
//            .foregroundColor(.gray)
//            .background(Color.clear)
//            .cornerRadius(8)
//            .overlay(
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(Color.gray, lineWidth: 1)
//            )
//            .datePickerStyle(.compact) // Compact style to keep it inline
//            .labelsHidden() // Hides default label for a cleaner look
