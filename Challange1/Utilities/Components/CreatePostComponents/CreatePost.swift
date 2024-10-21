//
//  CreatePost.swift
//  Challange1
//
//  Created by sumaiya on 21/10/2567 BE.
//

import SwiftUI
import PhotosUI

struct PhotoView: View {
    @State private var isShowingPhotoPicker = false
    @State private var selectedImages: [UIImage] = [] // Array to store selected images
    
    var body: some View {
        VStack {
            if selectedImages.isEmpty {
                // Show "Add Photo" button when no images are selected
                Button(action: {
                    isShowingPhotoPicker = true
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
            } else {
                // Show selected images in HStack
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(selectedImages.indices, id: \.self) { index in
                            Image(uiImage: selectedImages[index])
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipped()
                                .cornerRadius(8)
                        }
                        
                        // Plus button to add more photos
                        Button(action: {
                            isShowingPhotoPicker = true
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(Color.white)
                                .font(.title)
                                .frame(width: 50, height: 50)
                                .background(Color("BabyBlue"))
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .sheet(isPresented: $isShowingPhotoPicker) {
            PhotoPicker(selectedImages: $selectedImages)
        }
    }
}

// Custom PHPickerViewController for selecting images
struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImages: [UIImage]
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images // Only show images
        config.selectionLimit = 0 // Allow multiple selections
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                        if let uiImage = image as? UIImage {
                            DispatchQueue.main.async {
                                self.parent.selectedImages.append(uiImage)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PhotoView()
}

