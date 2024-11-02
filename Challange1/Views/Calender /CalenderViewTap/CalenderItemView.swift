//
//  TaskItemView.swift
//  project2
//
//  Created by sumaiya on 24/10/2567 BE.
//

import SwiftUI
import SwiftData

struct CalenderItemView: View {
    @Bindable var task: Task1
    @Environment(\.modelContext) private var context
    
    var platformList: [String]
    
    // State to control the swipe offset and delete popup
    @State private var offset: CGFloat = 0
    @State private var showDelete: Bool = false
    @State private var showDeletePopup = false
    
    var body: some View {
        ZStack(alignment: .trailing) {
            // Background delete button
            if showDelete {
                Button {
                    showDeletePopup = true // Show delete confirmation popup
                } label: {
                    Label("", systemImage: "trash")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .padding()
                        .frame(height: 100)
                        .frame(maxWidth: 180)
                        .background(Color.red)
                        .cornerRadius(12)
                }
                .padding(.trailing, 15)
                .transition(.move(edge: .trailing))
            }
            
            // Main content with swipe-to-delete functionality
            HStack(spacing: 10) {
                VStack(alignment: .center) {
                    Image(systemName: "document.fill")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 30))
                }
                .padding(.leading)
                
                Rectangle()
                    .frame(width: 1)
                    .foregroundColor(.gray)
                    .padding(.vertical)
                
                Text(task.title)
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                
                Spacer()
                
                HStack {
                    ForEach(platformList, id: \.self) { platform in
                        Image(systemName: "document.fill")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 20))
                    }
                }
                .padding(.trailing)
            }
            .frame(width: 350, height: 100, alignment: .leading)
            .background(Color("BabyBlue"))
            .cornerRadius(12)
            .offset(x: offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.width < 0 {
                            offset = value.translation.width
                        }
                    }
                    .onEnded { value in
                        withAnimation {
                            if value.translation.width < -100 {
                                offset = -100
                                showDelete = true
                            } else {
                                offset = 0
                                showDelete = false
                            }
                        }
                    }
            )
         
            .frame(maxWidth: .infinity, maxHeight: 100, alignment: .leading)
            .shadow(color: Color.black.opacity(0.4), radius: 3, x: 2, y: 3)
            .padding()
            
            // Delete confirmation popup overlay
            if showDeletePopup {
                
                DetetPostPopupView(
                    onDelete: {
                        withAnimation {
                            context.delete(task)
                            showDeletePopup = false
                        }
                    },
                    onCancel: {
                        withAnimation {
                            showDeletePopup = false
                        }
                    }
                )
                .background(Color.clear)
                .zIndex(1)
                .padding(.trailing,60)
            }
        }
    }
}



#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Task1.self, configurations: config)
    
    let task = Task1(title: "Example Task", date: Date(), isCompleted: false)

    CalenderItemView(task: task, platformList: ["","",""])
        .modelContainer(container)
}
