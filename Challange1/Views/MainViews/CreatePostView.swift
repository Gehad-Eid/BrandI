//
//  CreatePostView.swift
//  Challange1
//
//  Created by sumaiya on 21/10/2567 BE.
//

import SwiftUI

struct CreatePostView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var content: String = ""
    @State private var selectedDate: Date? = Date()
    @State private var selectedPlatforms: [Platform] = []
    @State private var isEditingEnabled: Bool = true
    
    @StateObject var vm = AddPostViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        VStack {
                            // Title Section
                            HStack {
                                TextField("Title", text: $vm.postTitle)
                                    .padding(.horizontal)
                                    .padding(.vertical, 10)
                                    .background(Color.clear)
                                    .font(.title2)
                                    .disabled(!isEditingEnabled)
                                    .onChange(of: vm.postTitle) { newValue in
                                        if vm.postTitle.count > 20 {
                                            vm.postTitle = String(vm.postTitle.prefix(20))
                                        }
                                    }
                                
                                Spacer()
                                
                                Text("\(vm.postTitle.count)/20")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .padding(.trailing)
                            }
                            
                            Divider()
                                .background(Color.gray)
                                .padding(.horizontal)
                            
                            // Content Section
                            VStack {
                                ZStack(alignment: .topLeading) {
                                    if vm.postContent.isEmpty {
                                        Text("Write your content here")
                                            .foregroundColor(.gray)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 12)
                                    }
                                    
                                    TextEditor(text: $vm.postContent)
                                        .background(Color.clear)
                                        .frame(height: 200)
                                        .padding(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color(UIColor.systemGray6))
                                        )
                                        .onChange(of: vm.postContent) { newValue in
                                            if vm.postContent.count > 300 {
                                                vm.postContent = String(vm.postContent.prefix(300))
                                            }
                                        }
                                }
                                
                                Spacer()
                                
                                HStack {
                                    Spacer()
                                    Text("\(vm.postContent.count)/300")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                }
                            }
                        }
                        
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(15)
                        .padding()
                        
                        //                        .background(Color.gray)
                        
                        // Photo selection section
                        PhotoView(selectedImages: $vm.imageList, isEditingEnabled: $isEditingEnabled)
                        
                        // Date selection section
                        SelecteDateView(selectedDate: $vm.selectedDate, isEditingEnabled: $isEditingEnabled)
                        
                        // Platform selection section
                        SelectPlatforms(selectedPlatforms: $vm.selectedPlatforms, isEditingEnabled: $isEditingEnabled)
                        
                        HStack {
                            Button(action: {
                                // Perform boost action
                            }) {
                                Text("Check Performance")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(10)
                            }
                            
                            if !isEditingEnabled {
                                Button(action: {
                                    // TODO: Handle publish action
                                }) {
                                    Text("Publish")
                                        .padding()
                                    //  .frame(maxWidth: .infinity)
                                        .background(Color.red.opacity(0.2))
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .padding(.top, 10)
                        
                        //PlatformSection()
                    }
                    .padding()
                    Spacer()
                    
                    
                }
            }
            .navigationTitle(isEditingEnabled ? "Add Post" : "Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if isEditingEnabled {
                        Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        }
                        .foregroundColor(Color.black)
                    } else {
                        Button("Edit") {
                            isEditingEnabled = true
                        }
                        .foregroundColor(.babyBlue)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    if isEditingEnabled {
                        Button("Add") {
                            isEditingEnabled = false // Disable editing when "Add" is pressed
                            
                            if let userID = UserDefaults.standard.string(forKey: "userID") {
                                vm.addPost(userId: userID)
                                print("userID: \(userID)")
                            } else {
                                print("vm.addPost(userId: userID!) failed")
                            }
                        }
                        .foregroundColor(Color("BabyBlue"))
                    }
                }
            }
        }
    }
}

#Preview {
    CreatePostView()
}

//struct PlatformSection :View {
//    @State private var selectedImagesIndices: Set<Int> = []
//    @State private var selectedDate: Date? = Date() // Tracks the selected date
//    @State private var isDatePickerPresented = false // Controls the presentation of DatePicker
//    @State private var isTapped = false
//
//    let images = [
//        "insta_choosen",
//        "linkedin_choosen",
//        "tiktok_choosen",
//        "x_choosen"
//    ]
//
//    let selectedImages = [
//        "instaEnable",
//        "linkedinEnable",
//        "tiktokEnable",
//        "xEnable"
//    ]
//    var body: some View {
//
//        VStack(alignment: .leading, spacing: 15) {
//            Text("Select Date")
//                .font(.system(size: 18, weight: .semibold))
//
//            Text(selectedDate != nil ? dateToString(selectedDate!) : "Select Date")
//
//
//                .frame(width:150, height: 40)
//                .foregroundColor(selectedDate != nil ? .gray : .white)
//                .background(selectedDate != nil ? Color.clear : Color("BabyBlue")) // Background color changes based on date selection
//                .cornerRadius(8)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 8)
//                        .stroke(Color.gray, lineWidth: 1) // Gray border
//                )
//                .onTapGesture {
//                    isDatePickerPresented = true
//                }
//                .sheet(isPresented: $isDatePickerPresented) {
//                    VStack {
//                        DatePicker(
//                            "Select a date",
//                            selection: Binding(
//                                get: { selectedDate ?? Date() },  // Provides current or default date
//                                set: { selectedDate = $0 }        // Updates the selected date
//                            ),
//                            displayedComponents: .date
//                        )
//                        .datePickerStyle(GraphicalDatePickerStyle())
//                        .labelsHidden()
//
//                        Button("Done") {
//                            isDatePickerPresented = false
//                        }
//                        .padding()
//                    }
//                    .padding()
//                }
//        }
//        .padding(.bottom,20)
//
//
//
//        //Platform
//        Text("Select Your Platform")
//            .font(.system(size: 18, weight: .semibold))
//        HStack(spacing: 40) {
//            ForEach(0..<4) { index in
//                Button(action: {
//                    // Toggle the selection state for the clicked image index
//                    if selectedImagesIndices.contains(index) {
//                        selectedImagesIndices.remove(index) // Deselect if already selected
//                    } else {
//                        selectedImagesIndices.insert(index) // Select if not already selected
//                    }
//                }) {
//
//                    Image(selectedImagesIndices.contains(index) ? selectedImages[index] : images[index])
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 50, height: 50)
//                        .clipped()
//                        .cornerRadius(10)
//                }
//            }
//        }
//        .padding(.top,5)
//
//        BoostPerformanceButton()
//            .padding(.top,10)
//    }
//}
//
//
//// Function to format the date as "Jun 10, 2024"
//private func dateToString(_ date: Date) -> String {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "MMM d, yyyy"
//    return dateFormatter.string(from: date)
//}
//#Preview {
//    PlatformSection()
//}
//
//
//
//
//struct BoostPerformanceButton: View {
//    var body: some View {
//        Button(action: {
//            // Action when button is tapped
//            print("Boost Your Performance button tapped!")
//        }) {
//            HStack {
//                Image("Vector")
//                    .resizable()
//                    .frame(width: 10,height: 10)
//                    .font(.title)
//                    .foregroundColor(.white)
//                Text("Boost Your Performance")
//                    .fontWeight(.semibold)
//                    .foregroundColor(.white)
//                    .font(.system(size: 16))
//            }
//            .frame(width:360 , height: 60)
//
//            .background(Color("BabyBlue"))
//            .cornerRadius(15)
//        }
//
//
//
//    }
//}
//
//#Preview {
//    BoostPerformanceButton()
//}


