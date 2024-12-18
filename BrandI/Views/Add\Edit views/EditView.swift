//
//  EditView.swift
//  Challange1
//
//  Created by Gehad Eid on 16/11/2024.
//

import SwiftUI
import Alamofire

struct EditView: View {
    @EnvironmentObject var agendaViewModel: AgendaViewModel
    @EnvironmentObject var mainViewModel: MainViewModel
    @Environment(\.dismiss) var dismiss
    
    @StateObject var vm = AddPostViewModel()
    
    @State private var isEditingEnabled: Bool = true
    @State private var doneloadingImages: Bool = false
    
    @State private var showSelectingImageSheet = false
    @State private var selectedImage: UIImage? = nil
    @State private var base64Image: String? = nil
    
    @State private var responseText: String = ""
    @State private var brandIdentity: String = ""
    
    @State private var loadingButton: Bool = false
    @State private var isLoading: Bool = false
    @State private var showPopup: Bool = false
    @State private var showBrandIdentitySheet: Bool = false
    
    @State var post: Post?
    @State var event: Event?
    
    var body: some View {
        ZStack {
            if showPopup {
                PopUpAi(isLoading: $isLoading, response: $responseText, showPopup: $showPopup)
                    .zIndex(100)
            }
            
            NavigationView {
                VStack {
                    ScrollView {
                        VStack(alignment: .leading) {
                            if isEditingEnabled {
                                // Title Section
                                EditViewComponent(title: "Title") { titleSection }
                            }
                            
                            if let post = post {
                                // Content Section
                                EditViewComponent(title: "Content") { contentSection }
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    if !isEditingEnabled {
                                        Text("Photos")
                                            .font(.headline.weight(.medium))
                                    }
                                    
                                    // Photo selection section
                                    SelectPhotosScrollView(selectedUIImagesAndNames: $vm.imageList, selectedImages: vm.imageDataList, isEditingEnabled: isEditingEnabled)
                                }
                                // Date Section
                                EditViewComponent(title: "Date") { dateSection }
                                
                                // Platform selection section
                                SelectPlatforms(selectedPlatforms: $vm.selectedPlatforms, isEditingEnabled: isEditingEnabled)
                            }
                            else if let event = event {
                                // Start Date Section
                                EditViewComponent(title: "Start Date") { dateSection }
                                // End Date Section
                                EditViewComponent(title: "End Date") { dateSection }
                            }
                        }
                        .padding()
                    }
                    
                    Spacer()
                    
                    // Buttons Section
                    buttonsSection
                }
                .navigationTitle(isEditingEnabled ? "Edit" : vm.title)
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    // Edit button
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if !isEditingEnabled {
                            Button("Edit") {
                                isEditingEnabled = true
                            }
                            .disabled(post != nil ? !doneloadingImages : isEditingEnabled)
                            .foregroundColor((post != nil ? doneloadingImages : !isEditingEnabled) ? Color("BabyBlue") : .gray)
                        }
                    }
                    
                    // Back button
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            dismiss()
                        }) {
                            HStack(spacing: 5) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 18, weight: .medium))
                                
                                Text("Back")
                                    .font(.system(size: 18))
                            }
                            .foregroundColor(Color("BabyBlue"))
                        }
                    }
                }
                .onAppear() {
                    loadUserBrand()
                    
                    if post != nil {
                        isEditingEnabled = false
                        doneloadingImages = false
                        Task {
                            // get the url to uiImage
                            if let userID = UserDefaults.standard.string(forKey: "userID") {
                                try await vm.getImageToUIImage(userId: userID, images: post?.images ?? [])
                                print("Done getting image to UIImage .........")
                                doneloadingImages = true
                            }
                        }
                        
                        vm.imageDataList = post?.images ?? []
                        vm.title = post?.title ?? ""
                        vm.postContent = post?.content ?? ""
                        vm.selectedDate = post?.date ?? Date()
                        vm.selectedPlatforms = post?.platforms ?? []
                        
                        if vm.imageDataList.isEmpty {
                            doneloadingImages = true
                        }
                    }
                    else if event != nil {
                        isEditingEnabled = false
                        
                        vm.title = event?.title ?? ""
                        vm.startDate = event?.startDate ?? Date()
                        vm.endDate = event?.endDate ?? Date()
                    }
                }
            }
            .task {
                try? await mainViewModel.loadCurrentUser()
            }
        }
    }
    
    // MARK: Sections
    // Title Section
    private var titleSection: some View {
        HStack {
            TextField("", text: $vm.title)
                .background(Color.clear)
                .font(.title2)
                .disabled(!isEditingEnabled)
                .onChange(of: vm.title) { newValue in
                    if vm.title.count > 20 {
                        vm.title = String(vm.title.prefix(20))
                    }
                }
            
            Spacer()
            
            if isEditingEnabled {
                Text("\(vm.title.count)/20")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
        }
    }
    
    // Content Section
    private var contentSection: some View {
        VStack {
            TextField("", text: $vm.postContent, axis: .vertical)
                .padding(.vertical, 12)
                .lineLimit(7)
                .disabled(!isEditingEnabled)
                .frame(height: isEditingEnabled ? 200 : .infinity, alignment: .top)
                .onChange(of: vm.postContent) { newValue in
                    if vm.postContent.count > 300 {
                        vm.postContent = String(vm.postContent.prefix(300))
                    }
                }
            
            Spacer()
            HStack {
                Spacer()
                if isEditingEnabled {
                    Text("\(vm.postContent.count)/300")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.trailing)
                }
            }
        }
    }
    
    // Content Section
    private var dateSection: some View {
        HStack {
            DatePicker("", selection: $vm.selectedDate, displayedComponents: .date)
                .frame(width: 140, height: 40)
                .foregroundColor(.white)
                .background(isEditingEnabled ? Color("BabyBlue") : Color("BabyBlue"))
                .cornerRadius(10)
                .datePickerStyle(.compact)
                .labelsHidden()
                .disabled(!isEditingEnabled)
            
            Spacer()
        }
    }
    
    // Buttons Section
    private var buttonsSection: some View {
        HStack(spacing: 16) {
            // Outlined Button
            if isEditingEnabled {
                Button(action: {
                    if isEditingEnabled {
                        if let userID = UserDefaults.standard.string(forKey: "userID") {
                            if post != nil , let postId = post?.postId {
                                loadingButton = true
                                vm.updatePost(userId: userID, postId: postId){
                                    Task {
                                        try await agendaViewModel.DoneAdding(userId: userID, type: "Your Post Has Been Updated Successfully!")
                                        dismiss()
                                        loadingButton = false
                                    }
                                }
                                print("postId: \(postId)")
                            }
                            else if event != nil , let eventId = event?.eventId {
                                loadingButton = true
                                vm.updateEvent(userId: userID, eventId: eventId){
                                    Task {
                                        try await agendaViewModel.DoneAdding(userId: userID, type: "Your Event Has Been Updated Successfully!")
                                        dismiss()
                                        loadingButton = false
                                    }
                                }
                                print("eventId: \(eventId)")
                            }
                        } else {
                            print("update failed")
                        }
                    }
                    print("outlined Button")
                }) {
                    Text(/*isEditingEnabled ?*/ loadingButton ? "Updating..." : "Save" /*: "Post"*/)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(loadingButton ? Color.gray : Color("BabyBlue"), lineWidth: 1)
                        )
                        .foregroundColor(loadingButton ? Color.gray : Color("BabyBlue"))
                }
                .disabled(loadingButton)
            }
            
            // Check Preformance Button
            if post != nil {
                Button(action: {
//                    if !brandIdentity.isEmpty {
                        if !vm.imageList.isEmpty {
                            if vm.imageList.count > 1 {
                                if !brandIdentity.isEmpty {
                                    showSelectingImageSheet = true
                                }
                                else {
                                    showBrandIdentitySheet = true
                                }
                                print("full image")
                            }
                            else if vm.imageList.count == 1 {
                                selectedImage = vm.imageList.first?.image
                                Task {
                                    do {
                                        try await doneSelectingImage()
                                    } catch {
                                        // Handle any errors here
                                        print("Error: \(error.localizedDescription)")
                                    }
                                }
                            }
                        } else {
                            Task {
                                do {
                                    try await doneSelectingImage()
                                } catch {
                                    // TODO: Handle errors
                                    print("Error: \(error.localizedDescription)")
                                }
                            }
                        }
//                    }
                }) {
                    Text("Check Preformance")
                    //  .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(doneloadingImages ? Color("BabyBlue") : .gray.opacity(0.5))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .disabled(!doneloadingImages)
                }
                .sheet(isPresented: $showSelectingImageSheet){
                    ImageSelectionSheet(
                        imageList: vm.imageList,
                        selectedImage: $selectedImage,
                        onDone: {
                            Task {
                                do {
                                    try await doneSelectingImage()
                                } catch {
                                    // Handle any errors here
                                    print("Error: \(error.localizedDescription)")
                                }
                            }
                        }
                    )
                }
                .sheet(isPresented: $showBrandIdentitySheet){
                    BrandIdentityView(){
                        // First, dismiss the sheet
                        showBrandIdentitySheet = false
                        
                        // Then proceed with the rest of the logic
                        Task {
                            if !vm.imageList.isEmpty {
                                if vm.imageList.count > 1 {
                                    showSelectingImageSheet = true
                                }
                                else if vm.imageList.count == 1 {
                                    Task {
                                        do {
                                            selectedImage = vm.imageList.first?.image
                                            try await doneSelectingImage()
                                        } catch {
                                            // TODO: Handle errors
                                            print("Error: \(error.localizedDescription)")
                                        }
                                    }
                                }
                            } else {
                                Task {
                                    do {
                                        try await doneSelectingImage()
                                    } catch {
                                        // TODO: Handle errors
                                        print("Error: \(error.localizedDescription)")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    private func loadUserBrand() {
        // Check if the user is loaded
        if let user = mainViewModel.user {
            // there's only one brand for user
            if let userBrand = user.brand?.first {
                let identityText = userBrand.purpose
                let audianceText = userBrand.audience
                let selectedCategory = userBrand.category
                let colorText = userBrand.colors
                let nameText = userBrand.name
                
                brandIdentity = "brand name: " + nameText + " purpose: " + identityText + " audience: " + audianceText + " category: " + selectedCategory + " color palate: " + colorText
            }
        }
    }
    
    private func doneSelectingImage() async throws {
        try? await mainViewModel.loadCurrentUser()
        loadUserBrand()
        
        if !brandIdentity.isEmpty {
            if let selectedImage = selectedImage {
                guard let imageData = selectedImage.jpegData(compressionQuality: 0.8) else { return }
                base64Image = imageData.base64EncodedString()
            } else {
                base64Image = ""
                print("passed")
            }
            
            showPopup = true
            isLoading = true
            
            let content = vm.title + "\n" + vm.postContent
            let text = """
                using this as brand identity "\(brandIdentity)", evaluate this post and does it match the brand identity by giving it a score out of 100 and a feedback if necessary of max 10 words and if there's a image attached check if it matches the color palate and check if it matchs the post if not dont add their score to the respond and make the respond EXACTLY in this EXACT format 'overallScore: int, compatability: int, grammar and spiling: int, color match: int, image match: int, feedback: str', where the overallScore is the mean for the scores. here is the post: "\(content)"
                """
            
            
            try await APIManager.shared.callOpenAIModel(imageBase64: base64Image ?? "", text: text){ response in
                if let response = response {
                    self.responseText = response
                    print(response)
                } else {
                    self.responseText = "Failed to get a response."
                }
                isLoading = false
            }
        }
        else {
            showBrandIdentitySheet = true
        }
    }
}


//    func callOpenAIModel(imageBase64: String, text: String, completion: @escaping (String?) -> Void) {
//        let baseUrl = "https://api.openai.com/v1/chat/completions"
//
//        let apiToken = "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"
//
//        let headers: HTTPHeaders = [
//            "Content-Type": "application/json",
//            "Authorization":  "Bearer \(apiToken)"
//        ]
//
//        let payload = [
//            "model": "gpt-4o-mini",
//            "messages": [
//                [
//                    "role": "user",
//                    "content": [
//                        [
//                            "type": "text",
//                            "text": "What’s in this image?"
//                        ],
//                        [
//                            "type": "image_url",
//                            "image_url": [
//                                "url": "data:image/jpeg;base64,\(imageBase64)",
//                                "detail": "low"
//                            ]
//                        ]
//                    ]
//                ]
//            ]
//        ] as! [String : Any]
//
//        AF.request(baseUrl, method: .post, parameters: payload, encoding: JSONEncoding.default, headers: headers)
//            .responseJSON { response in
//                switch response.result {
//                case .success(let value):
//                    print("Success: \(value)")
//                    if let json = value as? [String: Any],
//                       let choices = json["choices"] as? [[String: Any]],
//                       let message = choices.first?["message"] as? [String: Any],
//                       let content = message["content"] as? String {
//                        completion(content)
//                    } else {
//                        completion(nil)
//                    }
//                case .failure(let error):
//                    print("Error: \(error)")
//                    completion(nil)
//                }
//            }
//
////        AF.request(baseUrl,
////                   method: .post,
////                   parameters: payload,
////                   encoding: JSONEncoding.default,
////                   headers: headers
////        )
////        .responseString { data in
////            print(data.result)
////        }
//    }
