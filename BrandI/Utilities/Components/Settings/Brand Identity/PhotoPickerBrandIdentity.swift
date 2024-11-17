//
//  PhotoPickerBrandIdentity.swift
//  BrandI
//
//  Created by Gehad Eid on 17/11/2024.
//

import SwiftUI
import UIKit

struct PhotoPickerBrandIdentity: UIViewControllerRepresentable {
    @Binding var selectedUIImage: UIImage? 
    @Binding var isPresented: Bool
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var selectedUIImage: UIImage?
        @Binding var isPresented: Bool
        
        init(selectedUIImage: Binding<UIImage?>, isPresented: Binding<Bool>) {
            _selectedUIImage = selectedUIImage
            _isPresented = isPresented
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                selectedUIImage = uiImage
            }
            isPresented = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isPresented = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(selectedUIImage: $selectedUIImage, isPresented: $isPresented)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
