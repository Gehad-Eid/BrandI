//
//  AddPostView.swift
//  Challange1
//
//  Created by Gehad Eid on 19/10/2024.
//


import SwiftUI

@MainActor
final class AddPostViewModel: ObservableObject {
    
    @Published var postTitle: String = ""
    @Published var postContent: String = ""
    @Published var selectedDate = Date()
    @Published var selectedPlatforms: [String] = []
//    @Published var imageList: [UIImage] = []
    
    func addPost(userId: String) {
        let post = Post(postId: "", title: postTitle, content: postContent, date: selectedDate, platforms: selectedPlatforms)
        Task {
            try await UserManager.shared.addNewPost(userID: userId, post: post)
        }
    }
}

struct AddPostView: View {
    @State private var isShowingImagePicker = false
    @State private var isShowingBoostPopup = false
    
    @StateObject var vm = AddPostViewModel()
    
    @State var userId : String
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Title Section with Character Limit
                    VStack(alignment: .leading) {
                        TextField("Post Title", text: $vm.postTitle)
                            .font(.title)
                            .bold()
                            .onChange(of: vm.postTitle) { newValue in
                                if vm.postTitle.count > 25 {
                                    vm.postTitle = String(vm.postTitle.prefix(25))
                                }
                            }
                            .padding(.bottom, 5)
                        
                        Text("\(vm.postTitle.count)/25 characters")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    // Content Section with Character Limit
                    VStack(alignment: .leading) {
                        TextEditor(text: $vm.postContent)
                            .frame(height: 150)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                            .onChange(of: vm.postContent) { newValue in
                                if vm.postContent.count > 300 {
                                    vm.postContent = String(vm.postContent.prefix(300))
                                }
                            }
                        
                        Text("\(vm.postContent.count)/300 characters")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
//                    // Image Picker Section
//                    Text("Select Images")
//                    ScrollView(.horizontal) {
//                        HStack {
//                            ForEach(vm.imageList, id: \.self) { image in
//                                Image(uiImage: image)
//                                    .resizable()
//                                    .frame(width: 70, height: 70)
//                                    .cornerRadius(10)
//                            }
//                            Button(action: {
//                                isShowingImagePicker = true
//                            }) {
//                                Text("Add Image")
//                                    .padding()
//                                    .frame(width: 70, height: 70)
//                                    .background(Color.gray.opacity(0.1))
//                                    .cornerRadius(10)
//                            }
//                        }
//                    }
                    
                    // Date Picker
                    DatePicker("Select Date", selection: $vm.selectedDate, displayedComponents: .date)
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
                                    .background(vm.selectedPlatforms.contains(platform) ? Color.blue : Color.clear)
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
                leading: Button("Cancel", action: {
                    /* Cancel action */
                }),
                trailing: Button("Add", action: {
                    vm.addPost(userId: userId)
                })
            )
        }
//        .sheet(isPresented: $isShowingImagePicker) {
//            // Image picker (using PHPicker here)
//            ImagePicker(images: $vm.imageList)
//        }
    }
    
    // Toggle platform selection
    func togglePlatform(_ platform: String) {
        if let index = vm.selectedPlatforms.firstIndex(of: platform) {
            vm.selectedPlatforms.remove(at: index)
        } else {
            vm.selectedPlatforms.append(platform)
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
