//
//  BrandImageSection.swift
//  BrandI
//
//  Created by Gehad Eid on 17/11/2024.
//


import SwiftUI

struct BrandImageSection: View {
    @ObservedObject var brandVM: BrandIdintityViewModel
    @Binding var showImagePicker: Bool

    var body: some View {
        VStack(spacing: 20) {
            if let selectedImage = brandVM.selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .cornerRadius(20)
            } else {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.background)
                    .frame(width: 350, height: 300)
                    .overlay(
                        VStack {
                            Image("Vector")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .padding(.bottom, 30)
                            Text("Let us know how your brand looks")
                                .foregroundColor(.gray)
                            Button(action: {
                                checkPhotoLibraryPermission(isShowingPhotoPicker: $showImagePicker)
                            }) {
                                HStack {
                                    Image(systemName: "photo")
                                        .foregroundColor(.white)
                                    Text("Upload Image")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                }
                                .padding()
                                .frame(width: 200, height: 50)
                                .background(Color("BabyBlue"))
                                .cornerRadius(10)
                            }
                        }
                    )
            }
        }
        .onTapGesture {
            showImagePicker.toggle()
        }
        .sheet(isPresented: $showImagePicker) {
            PhotoPickerBrandIdentity(selectedUIImage: $brandVM.selectedImage, isPresented: $showImagePicker)
        }
    }
}