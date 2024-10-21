//
//  CreatePostView.swift
//  Challange1
//
//  Created by sumaiya on 21/10/2567 BE.
//

import SwiftUI

struct CreatePostView: View {
    @Environment(\.presentationMode) var presentationMode // For Cancel action
    @State private var title: String = ""
    @State private var content: String = ""
    var body: some View {
        ScrollView{
            VStack {
                VStack(alignment: .leading) {
                    
                    TextField("Title", text: $title)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color.clear)
                        .font(.title2)
                    
                    
                    Divider()
                        .background(Color.gray)
                        .padding(.horizontal)
                    
                    
                    TextField("Write your content here", text: $content)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color.clear)
                        .font(.body)
                    PhotoView()
                        .padding(.top,200)
                    PlatformSection()
                }
                .padding()
                Spacer()
                
                
            }
            .navigationTitle("Add Post")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss() // Dismiss CreatePostView
                        
                    } .foregroundColor(Color.black)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Next") {
                        
                    }.foregroundColor(Color("BabyBlue"))
                }
            }
        }
    }
}
#Preview {
    CreatePostView()
}

struct PlatformSection :View{
    @State private var selectedImagesIndices: Set<Int> = []
    @State private var selectedDate: Date? = Date() // Tracks the selected date
    @State private var isDatePickerPresented = false // Controls the presentation of DatePicker
    @State private var isTapped = false
    
    let images = [
        "insta_choosen",
        "linkedin_choosen",
        "tiktok_choosen",
        "x_choosen"
    ]
    
    let selectedImages = [
        "instaEnable",
        "linkedinEnable",
        "tiktokEnable",
        "xEnable"
    ]
    var body: some View {
        
        VStack(alignment: .leading, spacing: 15) {
            Text("Select Date")
                .font(.system(size: 18, weight: .semibold))
                   
                    Text(selectedDate != nil ? dateToString(selectedDate!) : "Select Date")
                
                    
                        .frame(width:150, height: 40)
                        .foregroundColor(selectedDate != nil ? .gray : .white)
                        .background(selectedDate != nil ? Color.clear : Color("BabyBlue")) // Background color changes based on date selection
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1) // Gray border
                        )
                        .onTapGesture {
                            isDatePickerPresented = true
                        }
                        .sheet(isPresented: $isDatePickerPresented) {
                            VStack {
                                DatePicker(
                                    "Select a date",
                                    selection: Binding(
                                        get: { selectedDate ?? Date() },  // Provides current or default date
                                        set: { selectedDate = $0 }        // Updates the selected date
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
        .padding(.bottom,20)
            
              
               
            //Platform
            Text("Select Your Platform")
            .font(.system(size: 18, weight: .semibold))
        HStack(spacing: 40) {
                        ForEach(0..<4) { index in
                            Button(action: {
                                // Toggle the selection state for the clicked image index
                                if selectedImagesIndices.contains(index) {
                                    selectedImagesIndices.remove(index) // Deselect if already selected
                                } else {
                                    selectedImagesIndices.insert(index) // Select if not already selected
                                }
                            }) {
                               
                                Image(selectedImagesIndices.contains(index) ? selectedImages[index] : images[index])
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipped()
                                    .cornerRadius(10)
                            }
                        }
                    }
        .padding(.top,5)
        
        BoostPerformanceButton()
            .padding(.top,10)
                }
            }


// Function to format the date as "Jun 10, 2024"
private func dateToString(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy"
    return dateFormatter.string(from: date)
}
    #Preview {
        PlatformSection()
    }
    



struct BoostPerformanceButton: View {
    var body: some View {
        Button(action: {
            // Action when button is tapped
            print("Boost Your Performance button tapped!")
        }) {
            HStack {
                Image("Vector")
                    .resizable()
                    .frame(width: 10,height: 10)
                    .font(.title)
                    .foregroundColor(.white)
                Text("Boost Your Performance")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .font(.system(size: 16))
            }
            .frame(width:360 , height: 60)
         
            .background(Color("BabyBlue"))
            .cornerRadius(15)
        }
        
       
       
    }
}

#Preview {
    BoostPerformanceButton()
}
