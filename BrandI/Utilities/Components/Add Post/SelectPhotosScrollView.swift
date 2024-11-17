//
//  PhotoView.swift
//  Challange1
//
//  Created by sumaiya on 21/10/2567 BE.
//  Edited by Gehad Eid on 05/11/2024

import SwiftUI
import PhotosUI

struct SelectPhotosScrollView: View {
    @State private var isShowingPhotoPicker = false
    @Binding var selectedUIImagesAndNames: [(image: UIImage, name: String)]
    
    var selectedImages: [ImageData]? = nil
    var isEditingEnabled: Bool? = nil
    
    @State private var currentImageIndex: Int = 0
    @State private var isViewingImage = false
    
    var body: some View {
        VStack {
            // Show "Add Photo" button when no images are selected
            if selectedUIImagesAndNames.isEmpty, isEditingEnabled ?? true {
                Button(action: {
                    checkPhotoLibraryPermission(isShowingPhotoPicker: $isShowingPhotoPicker)
                }) {
                    HStack {
                        Image(systemName: "photo.on.rectangle")
                            .font(.title)
                        Text("Add Photo")
                            .font(.title3)
                    }
                    .foregroundColor(Color("BabyBlue"))
                    .padding()
                }
            }
            // Show selected images if selected with a '+' button
            else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        HStack {
                            if !(isEditingEnabled ?? true) {
                                if let selectedImages = selectedImages, !selectedImages.isEmpty {
                                    ForEach(selectedImages.indices, id: \.self) { index in
                                        AsyncImage(url: URL(string: selectedImages[index].imageUrl)){ image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 80, height: 80)
                                                .clipped()
                                                .cornerRadius(8)
                                                .padding(.vertical)
                                                .padding(.leading, 10)
                                        } placeholder: {
                                            ProgressView()
                                                .frame(width: 80, height: 80)
                                                .clipped()
                                                .cornerRadius(8)
                                                .padding(.vertical)
                                                .padding(.leading, 10)
                                        }
                                    }
                                }
                                else {
                                    HStack {
                                        Image(systemName: "photo.badge.exclamationmark")
                                            .font(.title)
                                        Text("No Photo")
                                            .font(.title3)
                                    }
                                    .foregroundColor(Color("Text"))
                                    .padding()
                                }
                            }
                            else {
                                HStack {
                                    ForEach(selectedUIImagesAndNames.indices, id: \.self) { index in
                                        ZStack(alignment: .topTrailing) {
                                            Image(uiImage: selectedUIImagesAndNames[index].image)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 80, height: 80)
                                                .clipped()
                                                .cornerRadius(8)
                                                .onTapGesture {
                                                    // To show the fullscreen view
                                                    currentImageIndex = index
                                                    isViewingImage = true
                                                }
                                            
                                            Button(action: {
                                                selectedUIImagesAndNames.remove(at: index)
                                            }) {
                                                Image(systemName: "xmark.app.fill")
                                                    .resizable()
                                                    .frame(width: 20, height: 20)
                                                //  .font(.title)
                                                    .clipped()
                                                    .cornerRadius(8)
                                                    .foregroundColor(.red)
                                                    .background(Circle().fill(Color.white))
                                            }
                                            .zIndex(1)
                                            .offset(x: 5, y: -5) // Position it at the top-right corner
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                            }
                            
                            // Plus button to add more photos
                            if isEditingEnabled ?? true {
                                Button(action: {
                                    checkPhotoLibraryPermission(isShowingPhotoPicker: $isShowingPhotoPicker)
                                }) {
                                    Image(systemName: "plus")
                                        .foregroundColor(Color.white)
                                        .font(.title)
                                        .frame(width: 80, height:80)
                                        .background(Color("BabyBlue"))
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }
                }
                .background(Color("graybackground"))
                .cornerRadius(15)
            }
        }
        .padding(.top, isEditingEnabled ?? true ? 10 : 0)
        .sheet(isPresented: $isShowingPhotoPicker) {
            PhotoPicker(selectedUIImagesAndNames: $selectedUIImagesAndNames)
        }
        .fullScreenCover(isPresented: $isViewingImage) {
            FullScreenImageCarousel(
                images: selectedUIImagesAndNames.map { $0.image },
                currentIndex: $currentImageIndex,
                isPresented: $isViewingImage
            )
        }
    }
}

#Preview {
    SelectPhotosScrollView(selectedUIImagesAndNames: .constant([]))
}
