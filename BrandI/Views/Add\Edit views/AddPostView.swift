//
//  AddPostView.swift
//  Challange1
//
//  Created by Gehad Eid on 19/10/2024.
//

import SwiftUI

struct AddPostView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var agendaViewModel: AgendaViewModel
    
    @StateObject var vm = AddPostViewModel()
    
    @State private var selectedTab: String = "Add New Post"
    @State private var loadingButton: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Select Option", selection: $selectedTab) {
                    Text("Post").tag("Add New Post")
                    Text("Event").tag("Add New Event")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .padding(.top)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        VStack {
                            // Title section
                            TitleTextBox(title: $vm.title, selectedTab: selectedTab)
                            
                            if selectedTab == "Add New Post" {
                                // Content section
                                ContentTextBox(content: $vm.postContent)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(15)
                        
                        if selectedTab == "Add New Post" {
                            // Photo selection section
                            SelectPhotosScrollView(selectedUIImagesAndNames: $vm.imageList)
                            
                            // Date selection section
                            SelecteDateView(selectedDate: $vm.selectedDate, selectedTab: $selectedTab)
                            
                            // Platform selection section
                            SelectPlatforms(selectedPlatforms: $vm.selectedPlatforms)
                        }
                        else if selectedTab == "Add New Event" {
                            // Date selection section
                            SelecteDateView(selectedDate: $vm.startDate, selectedTab: $selectedTab)
                            
                            // Date selection section
                            SelecteDateView(selectedDate: $vm.endDate, selectedTab: $selectedTab)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Add New")
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Add button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(loadingButton ? "Adding..." : "Add") {
                        if let userID = UserDefaults.standard.string(forKey: "userID") {
                            if selectedTab == "Add New Post" {
                                // Add post action
                                loadingButton = true
                                vm.addPost(userId: userID) {
                                    Task {
                                        try await agendaViewModel.DoneAdding(userId: userID, type: "Your Post Has Been Added Successfully!")
                                        dismiss()
                                        loadingButton = false
                                    }
                                }
                            }
                            else if selectedTab == "Add New Event" {
                                // Add event action
                                loadingButton = true
                                vm.addEvent(userId: userID) {
                                    Task {
                                        try await agendaViewModel.DoneAdding(userId: userID, type: "Your Event Has Been Added Successfully!")
                                        dismiss()
                                        loadingButton = true
                                    }
                                }
                            }
                        } else {
                            print("UserId not found")
                        }
                    }
                    .foregroundColor(
                        loadingButton // Check if loadingButton is true
                            ? .gray // Gray color when loading
                            : (
                                (selectedTab == "Add New Post"
                                 ? vm.isPostFormValid
                                 : vm.isEventFormValid)
                                ? Color("BabyBlue")
                                : .gray
                            )
                    )
                    .disabled(
                        loadingButton // Disable the button when loadingButton is true
                            || !(selectedTab == "Add New Post"
                                 // Disable if form is incomplete based on the form type
                                 ? vm.isPostFormValid
                                 : vm.isEventFormValid)
                    )

//                    .foregroundColor(
//                        (
//                            selectedTab == "Add New Post"
//                            ? vm.isPostFormValid
//                            : vm.isEventFormValid
//                        )
//                        ? Color("BabyBlue")
//                        : .gray
//                    )
//                    .disabled(!(selectedTab == "Add New Post"
//                                // Disable if form is incomplete based on the form type
//                                ? vm.isPostFormValid
//                                : vm.isEventFormValid)
//                    )
                }
                
                // Cancel button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(Color("Text"))
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddPostView()
    }
}
