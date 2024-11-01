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
    @State private var selectedTab: String = "Add Post"
    
    @State var post: Post?
    @State var event: Event?
    
    @StateObject var vm = AddPostViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if isEditingEnabled, post == nil, event == nil {
                    Picker("Select Option", selection: $selectedTab) {
                        Text("Post").tag("Add Post")
                        Text("Event").tag("Add Event")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .padding(.top)
                }
                
                ScrollView {
                    if selectedTab == "Add Post", event == nil {
                        addPostSection
                    } else if selectedTab == "Add Event", post == nil {
                        addEventSection
                    }
                }
            }
            .navigationTitle((vm.title.isEmpty || isEditingEnabled) ? "Add New" : vm.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if isEditingEnabled {
                        Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        }
                        .foregroundColor(.black)
                    } else {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Image(systemName: "chevron.backward")
                                Text("Back")
                            }
                            .foregroundColor(Color("BabyBlue"))
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    if isEditingEnabled {
                        Button("Add") {
                            isEditingEnabled = false
                            
                            if let userID = UserDefaults.standard.string(forKey: "userID") {
                                
                                if selectedTab == "Add Post" {
                                    if post != nil , let postId = post?.postId {
                                        print("postId: \(post)")
                                        vm.updatePost(userId: userID, postId: postId)
                                        print("postId: \(postId)")
                                    } else {
                                        vm.addPost(userId: userID)
                                    }
                                    
                                } else {
                                    if event != nil , let eventId = event?.eventId {
                                        vm.updateEvent(userId: userID, eventId: eventId)
                                        print("eventId: \(eventId)")
                                    } else {
                                        vm.addEvent(userId: userID)
                                        print("addEvent - userID: \(userID)")
                                    }
                                }
                                
                            } else {
                                print("vm.addPost(userId: userID!) failed")
                            }
                        }
                        .foregroundColor(Color("BabyBlue"))
                        
                    } else {
                        Button("Edit") {
                            isEditingEnabled = true
                        }
                        .foregroundColor(Color("BabyBlue"))
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear() {
            if post != nil {
                isEditingEnabled = false
                selectedTab = "Add Post"
                
                Task {
                    // get the url to uiImage
                    if let userID = UserDefaults.standard.string(forKey: "userID") {
                        try await vm.getImageToUIImage(userId: userID, images: post?.images ?? [])
                    }
                }
                
                vm.imageDataList = post?.images ?? []
                vm.title = post?.title ?? ""
                vm.postContent = post?.content ?? ""
                vm.selectedDate = post?.date ?? Date()
                vm.selectedPlatforms = post?.platforms ?? []
            }
            else if event != nil {
                isEditingEnabled = false
                selectedTab = "Add Event"
                
                vm.title = event?.title ?? ""
                vm.startDate = event?.startDate ?? Date()
                vm.endDate = event?.endDate ?? Date()
            }
        }
        .onChange(of: vm.postId) { newPostId in
            if !newPostId.isEmpty {
                self.post = Post(postId: newPostId, title: vm.title, content: vm.postContent, date: vm.selectedDate, platforms: vm.selectedPlatforms, isDraft: vm.isDraft)
            }
        }
        .onChange(of: vm.eventId) { newEventId in
            if !newEventId.isEmpty {
                self.event = Event(eventId: newEventId, title: vm.title, startDate: vm.startDate, endDate: vm.endDate)
            }
        }
    }
    
    
    //MARK: View Sections
    private var titleSection: some View {
        Group {
            if isEditingEnabled || (event != nil && !isEditingEnabled) {
                HStack {
                    TextField("Title", text: $vm.title)
                    //                        .padding(.horizontal)
                    //                        .padding(.vertical, 10)
                        .background(Color.clear)
                        .font(.title2)
                        .disabled((event != nil && !isEditingEnabled) ? true : !isEditingEnabled)
                        .onChange(of: vm.title) { newValue in
                            if vm.title.count > 20 {
                                vm.title = String(vm.title.prefix(20))
                            }
                        }
                    
                    Spacer()
                    
                    Text("\(vm.title.count)/20")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.trailing)
                }
                
                if selectedTab == "Add Post" {
                    Divider()
                        .background(Color.gray)
                        .padding(.horizontal)
                }
            }
        }
    }
    
    private var contentSection: some View {
        VStack {
            TextField("Write your content here", text: $vm.postContent, axis: .vertical)
            //                .padding(.horizontal, 12)
                .padding(.vertical, 12)
                .lineLimit(7)
                .frame(height: 200, alignment: .top)
                .disabled(!isEditingEnabled)
                .onChange(of: vm.postContent) { newValue in
                    if vm.postContent.count > 300 {
                        vm.postContent = String(vm.postContent.prefix(300))
                    }
                }
            
            Spacer()
            if isEditingEnabled {
                HStack {
                    Spacer()
                    Text("\(vm.postContent.count)/300")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.trailing)
                }
            }
        }
    }
    
    // MARK: Add Post Section
    private var addPostSection: some View {
        VStack(alignment: .leading) {
            VStack {
                titleSection
                contentSection
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            // Photo selection section
            PhotoView(selectedUIImagesAndNames: $vm.imageList, selectedImages: $vm.imageDataList, isEditingEnabled: $isEditingEnabled)
            
            // Date selection section
            SelecteDateView(selectedDate: $vm.selectedDate, isEditingEnabled: $isEditingEnabled)
            
            // Platform selection section
            SelectPlatforms(selectedPlatforms: $vm.selectedPlatforms, isEditingEnabled: $isEditingEnabled)
            
            HStack {
                Button(action: {
                    // TODO: Handle boost action
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
                            .background(Color.red.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.top, 10)
        }
        .padding()
    }
    
    // MARK: Add Event Section
    private var addEventSection: some View {
        VStack(alignment: .leading) {
            VStack {
                titleSection
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            .padding()
            
            // Date selection section
            SelecteDateView(selectedDate: $vm.startDate, isEditingEnabled: $isEditingEnabled)
            
            // Date selection section
            SelecteDateView(selectedDate: $vm.endDate, isEditingEnabled: $isEditingEnabled)
            
        }
        .padding()
    }
}

#Preview {
    CreatePostView(post: Post(postId: "1", title: "Ppo title", content: "content her babe", date: Date(), images: [], platforms: [.linkedin, .twitter], recommendation: "", isDraft: false))
}
