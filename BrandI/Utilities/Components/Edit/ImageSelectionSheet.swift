//
//  ImageSelectionSheet.swift
//  BrandI
//
//  Created by Gehad Eid on 17/11/2024.
//

import SwiftUI
import Alamofire

struct ImageSelectionSheet: View {
    @Environment(\.dismiss) var dismiss
    
    let imageList: [(image: UIImage, name: String)]
    @Binding var selectedImage: UIImage?
    let onDone: () -> Void
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Important: Select the Best Image for Analysis")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.red.opacity(0.8))
                            .padding(.horizontal)
                            .multilineTextAlignment(.leading)
                        
                        Text("To get the most accurate feedback for your post, please select an image that best matches the content or represents the main theme of your post. This image will be analyzed by our AI to provide you with personalized feedback.")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                        
                        Spacer()
                    }
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                        ForEach(imageList, id: \.name) { imageItem in
                            ZStack {
                                Image(uiImage: imageItem.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(selectedImage == imageItem.image ? Color.blue : Color.clear, lineWidth: 3)
                                    )
                                    .opacity(selectedImage == nil || selectedImage == imageItem.image ? 1.0 : 0.5)
                                    .onTapGesture {
                                        if selectedImage == imageItem.image {
                                            selectedImage = nil
                                        } else {
                                            selectedImage = imageItem.image
                                        }
                                    }
                                
                                if selectedImage == imageItem.image {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.blue)
                                        .background(Circle().fill(Color.white))
                                        .font(.headline)
                                        .offset(x: -35, y: -35)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Select an Image")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        selectedImage = nil
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                        onDone()
                    }
                    .disabled(selectedImage == nil)
                }
            }
        }
        .onDisappear {
            selectedImage = nil
        }
    }
}
