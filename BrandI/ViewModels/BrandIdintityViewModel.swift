//
//  BrandIdintityViewModel.swift
//  BrandI
//
//  Created by Gehad Eid on 17/11/2024.
//

import SwiftUI

@MainActor
final class BrandIdintityViewModel : ObservableObject {
    @Published var identityText: String = ""
    @Published var selectedCategory = "Technology"
    @Published var nameText: String = ""
    @Published var audianceText: String = ""
    @Published var colorText: String = ""
    @Published var selectedImage: UIImage? = nil
    
    // MARK: Handle Image Upload and Save
    func handleImageUploadAndSave(updateBrand: @escaping ([BarandIdentity]) async throws -> Void) async {
        do {
            // Ensure there is a selected image
            guard let image = selectedImage,
                  let imageData = image.jpegData(compressionQuality: 0.8) else {
                print("Error: No image selected or unable to convert image.")
                return
            }
            
            // Convert the image data to a Base64-encoded string
            let imageBase64 = imageData.base64EncodedString()
            
            // Upload the image to the API
            try await APIManager.shared.callOpenAIModel(imageBase64: imageBase64, text: "what's the color palate of this image?, responde with the HEX colors exactly in the format of 'hex,hex,hex,..'"){ response in
                if response != nil {
                    // Save the response to colorText
                    DispatchQueue.main.async {
                        self.colorText = response?.description ?? "No colors detected"
                    }
                    print(response?.description)
                } else {
                    print("error")
                }
            }
            
            // Update the database with the new data
            let brand = [
                BarandIdentity(
                    purpose: identityText,
                    audience: audianceText,
                    category: selectedCategory,
                    colors: colorText,
                    name: nameText
                )
            ]
            
            try await updateBrand(brand)
            print("Done")
            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
