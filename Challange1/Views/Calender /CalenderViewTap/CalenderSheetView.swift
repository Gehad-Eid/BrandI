//
//  TaskSheetView.swift
//  project2
//
//  Created by sumaiya on 24/10/2567 BE.
//

import SwiftUI
import SwiftData

struct CalenderSheetView: View {
    @State private var taskTitle: String = ""
    @State private var taskDate: Date = .init()
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    var body: some View {
            VStack(alignment: .leading, spacing: 25) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Button("Cancel") {
                            dismiss()
                        }
                        .foregroundColor(.red)
                        
                        Spacer()
                        
                        Button {
                            let task = Task1(title: taskTitle, date: taskDate)
                            do {
                                context.insert(task)
                                try context.save()
                                dismiss()
                            } catch {
                                print(error.localizedDescription)
                            }
                        } label: {
                            Text("Add")
                                .foregroundColor(.primary)
                        }
                    }
                    
                    Spacer()
                    
                    Text("Task Title")
                        .font(.body)
                        .padding(.top, 10)
                        .foregroundColor(Color.primary)
                    
                    TextField("  Your Task Title", text: $taskTitle)
                        .font(.body)
                        .frame(height: 35)
                        .background(.secondary)
                        .foregroundColor(Color.black)
                        .cornerRadius(6)
                    
                    Text("Task Date")
                        .font(.body)
                        .foregroundColor(Color.primary)
                    
                    DatePicker("", selection: $taskDate)
                        .datePickerStyle(.compact)
                        .padding(.horizontal)
                }
                .padding()
                
                Spacer()
                
                Button {
                    let task = Task1(title: taskTitle, date: taskDate)
                    do {
                        context.insert(task)
                        try context.save()
                        dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                } label: {
                    Text("Add Task")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color.white)
                        .foregroundColor(Color.accentColor)
                        .clipShape(.rect(cornerRadius: 10))
                        .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .ignoresSafeArea()
            .preferredColorScheme(.dark)
            .padding(.bottom)
    }
}

#Preview {
    CalenderSheetView()
}

// calender 3
