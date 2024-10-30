//
//  TaskItemView.swift
//  project2
//
//  Created by sumaiya on 24/10/2567 BE.
//

import SwiftUI
import SwiftData

struct TaskItemView: View {
    @Bindable var task: Task1
    @Environment(\.modelContext) private var context
   
   
    var platformList: [String]
    var body: some View {
        
        
        HStack(spacing: 10) {
            
            HStack {
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
                    Spacer()
                    
                    // Loop through the platform array
                    ForEach(platformList, id: \.self) { platformList in
                        Image(systemName: "document.fill")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 20))
                    }
                }
                .padding(.trailing)
                .padding(.top, -28)
            }
            .frame(width: 350, height: 100, alignment: .leading)
                       .background(Color("BabyBlue"))
                       .cornerRadius(12) 
            
        }
        
        
        
        .frame(maxWidth: .infinity, maxHeight: 35, alignment: .leading)
        .shadow(color: Color.black.opacity(0.4), radius: 3, x: 2, y: 3)
        
        .padding()
        
        .onTapGesture {
            withAnimation(.snappy) {
                task.isCompleted.toggle()
            }
        }

    }
    
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Task1.self, configurations: config)
    
    let task = Task1(title: "Example Task", date: Date(), isCompleted: false)

    TaskItemView(task: task, platformList: ["","",""])
        .modelContainer(container)
}
