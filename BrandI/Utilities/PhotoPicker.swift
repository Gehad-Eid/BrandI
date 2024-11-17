//
//  PhotoPicker.swift
//  Challange1
//
//  Created by Gehad Eid on 16/10/2024.
//

import SwiftUI
import PhotosUI

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
