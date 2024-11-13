//
//  PhotoView.swift
//  Challange1
//
//  Created by sumaiya on 21/10/2567 BE.
//

import SwiftUI
import PhotosUI

struct PhotoView: View {
    @State private var isShowingPhotoPicker = false
    @Binding var selectedUIImagesAndNames: [(image: UIImage, name: String)]
    @Binding var selectedImages: [ImageData]
    
    
    @Binding var isEditingEnabled: Bool
    
    var body: some View {
        VStack {
            if selectedUIImagesAndNames.isEmpty , isEditingEnabled {
                // Show "Add Photo" button when no images are selected
                Button(action: {
//                    isShowingPhotoPicker = true
                    checkPhotoLibraryPermission()
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
                        if !isEditingEnabled {
                            ForEach(selectedImages.indices, id: \.self) { index in
                                AsyncImage(url: URL(string: selectedImages[index].imageUrl)){ image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipped()
                                        .cornerRadius(8)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 50, height: 50)
                                        .clipped()
                                        .cornerRadius(8)
                                }
                            }
                        }
                        else {
                            ForEach(selectedUIImagesAndNames.indices, id: \.self) { index in
                                //TODO: improve that + add delete
                                Image(uiImage: selectedUIImagesAndNames[index].image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipped()
                                    .cornerRadius(8)
                            }
                        }
                        
                        if isEditingEnabled {
                            // Plus button to add more photos
                            Button(action: {
                                //isShowingPhotoPicker = true
                                checkPhotoLibraryPermission()
                            }) {
                                Image(systemName: "plus")
                                    .foregroundColor(Color.white)
                                    .font(.title)
                                    .frame(width: 50, height: 50)
                                    .background(Color("BabyBlue"))
                                    .cornerRadius(8)
                            }
                        }
                    }
                    }
                    .frame(width: 360, height: 66)
                    .background(Color("graybackground"))
                    .cornerRadius(18)
                    .padding(.horizontal)
                
            }
        }
        .padding(.top, 10)
        .sheet(isPresented: $isShowingPhotoPicker) {
            PhotoPicker(selectedUIImagesAndNames: $selectedUIImagesAndNames)
        }
    }
    
    func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            // Permission granted, show the picker
            isShowingPhotoPicker = true
        case .denied, .restricted:
            print("User has denied or restricted access to photos.")
        case .notDetermined:
            // Request permission if it hasn't been determined yet
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized {
                    DispatchQueue.main.async {
                        isShowingPhotoPicker = true
                    }
                }
            }
        default:
            print("Unknown authorization status.")
        }
    }
}


struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedUIImagesAndNames: [(image: UIImage, name: String)]
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 0
        
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
                                let filename = result.itemProvider.suggestedName ?? UUID().uuidString + ".jpeg"
                                self.parent.selectedUIImagesAndNames.append((image: uiImage, name: filename))
                            }
                        }
                    }
                }
            }
        }
    }
}

// Custom PHPickerViewController for selecting images
//struct PhotoPicker: UIViewControllerRepresentable {
//    @Binding var selectedUIImagesAndNames: [(image: UIImage, name: String)]
//
//    func makeUIViewController(context: Context) -> PHPickerViewController {
//        var config = PHPickerConfiguration()
//        config.filter = .images // Only show images
//        config.selectionLimit = 0 // Allow multiple selections
//
//        let picker = PHPickerViewController(configuration: config)
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
//
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(self)
//    }
//
//    class Coordinator: NSObject, PHPickerViewControllerDelegate {
//        var parent: PhotoPicker
//
//        init(_ parent: PhotoPicker) {
//            self.parent = parent
//        }
//
//        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//            picker.dismiss(animated: true)
//
//            for result in results {
//                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
//                    result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
//                        if let uiImage = image as? UIImage {
//                            DispatchQueue.main.async {
//                                let filename = result.itemProvider.suggestedName ?? UUID().uuidString + ".jpeg"
//                                self.parent.selectedUIImagesAndNames.append((image: uiImage, name: filename))
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }










//    class Coordinator: NSObject, PHPickerViewControllerDelegate {
//        var parent: PhotoPicker
//
//        init(_ parent: PhotoPicker) {
//            self.parent = parent
//        }
//
//        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//            picker.dismiss(animated: true)
//
//            for result in results {
//                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
//                    result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
//                        if let uiImage = image as? UIImage {
//                            DispatchQueue.main.async {
//                                self.parent.selectedImages.append(uiImage)
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//}

#Preview {
    PhotoView(selectedUIImagesAndNames: .constant([]), selectedImages: .constant([]), isEditingEnabled: .constant(false))
}


