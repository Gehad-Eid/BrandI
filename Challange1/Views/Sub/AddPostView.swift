//
//  AddPostView.swift
//  Challange1
//
//  Created by Gehad Eid on 19/10/2024.
//


import SwiftUI

struct AddPostView: View {
    @State private var postTitle: String = ""
    @State private var postContent: String = ""
    @State private var selectedDate = Date()
    @State private var selectedPlatforms: [String] = []
    @State private var imageList: [UIImage] = []
    @State private var isShowingImagePicker = false
    @State private var isShowingBoostPopup = false
    
    @State var userId : String
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Title Section with Character Limit
                    VStack(alignment: .leading) {
                        TextField("Post Title", text: $postTitle)
                            .font(.title)
                            .bold()
                            .onChange(of: postTitle) { newValue in
                                if postTitle.count > 25 {
                                    postTitle = String(postTitle.prefix(25))
                                }
                            }
                            .padding(.bottom, 5)
                        
                        Text("\(postTitle.count)/25 characters")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    // Content Section with Character Limit
                    VStack(alignment: .leading) {
                        TextEditor(text: $postContent)
                            .frame(height: 150)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                            .onChange(of: postContent) { newValue in
                                if postContent.count > 300 {
                                    postContent = String(postContent.prefix(300))
                                }
                            }
                        
                        Text("\(postContent.count)/300 characters")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    // Image Picker Section
                    Text("Select Images")
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(imageList, id: \.self) { image in
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 70, height: 70)
                                    .cornerRadius(10)
                            }
                            Button(action: {
                                isShowingImagePicker = true
                            }) {
                                Text("Add Image")
                                    .padding()
                                    .frame(width: 70, height: 70)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(10)
                            }
                        }
                    }
                    
                    // Date Picker
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    
                    // Platform Picker Section
                    Text("Select Your Platform")
                        .font(.headline)
                    HStack {
                        ForEach(platforms, id: \.self) { platform in
                            Button(action: {
                                togglePlatform(platform)
                            }) {
                                Image(platform)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .background(selectedPlatforms.contains(platform) ? Color.blue : Color.clear)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    
                    // Boost Performance Button
                    Button(action: {
                        isShowingBoostPopup = true
                    }) {
                        Text("✨ Boost Your Performance ✨")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                    .alert(isPresented: $isShowingBoostPopup) {
                        Alert(
                            title: Text("Boost Performance"),
                            message: Text("Here’s how to improve your post performance! 🚀"),
                            dismissButton: .default(Text("Got it!"))
                        )
                    }
                }
                .padding()
            }
            .navigationBarTitle("Add Post", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel", action: { /* Cancel action */ }),
                trailing: Button("Add", action: { /* Add post action */ })
            )
        }
        .sheet(isPresented: $isShowingImagePicker) {
            // Image picker (using PHPicker here)
            ImagePicker(images: $imageList)
        }
    }
    
    // Toggle platform selection
    func togglePlatform(_ platform: String) {
        if let index = selectedPlatforms.firstIndex(of: platform) {
            selectedPlatforms.remove(at: index)
        } else {
            selectedPlatforms.append(platform)
        }
    }

    // Dummy platform data
    var platforms: [String] = [
        "instagram_icon", "x_icon", "tiktok_icon", "linkedin_icon"
    ]
}

struct AddPostView_Previews: PreviewProvider {
    static var previews: some View {
        AddPostView(userId: "String")
    }
}
