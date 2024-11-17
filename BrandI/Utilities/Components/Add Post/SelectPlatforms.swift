//
//  SelectPlatforms.swift
//  Challange1
//
//  Created by Gehad Eid on 26/10/2024.
//

import SwiftUI

struct SelectPlatforms: View {
    @Binding var selectedPlatforms: [Platform]
    var isEditingEnabled: Bool? = nil
    
    let images = [
        "insta_choosen",
        "linkedin_choosen",
        "tiktok_choosen",
        "x_choosen"
    ]
    
    let selectedImages = [
        "instaEnable",
        "linkedinEnable",
        "tiktokEnable",
        "xEnable"
    ]
    
    // Map images to platforms
    let platformList: [Platform] = [.instagram, .linkedin, .tiktok, .twitter]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(isEditingEnabled ?? true ? "Select Platforms" : "Platforms")
                .font(.headline.weight(.regular))
            HStack {
                HStack(alignment: .center, spacing: 20) {
                    // Show only selected platforms when not editing, or all platforms if editing
                    ForEach(platformList.indices, id: \.self) { index in
                        let platform = platformList[index]
                        let isSelected = selectedPlatforms.contains(platform)
                        
                        let iconName = isSelected ? selectedImages[index] : images[index]
                        
                        Button(action: {
                            togglePlatformSelection(platform)
                        }) {
                            Image(iconName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 45, height:45)
                                .clipped()
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.clear, lineWidth: 2)
                                )
                        }
                        .disabled(!(isEditingEnabled ?? true))
                    }
                }
                .padding()
                Spacer()
            }
            .background(Color("graybackground"))
            .cornerRadius(15)
        }
        .padding(.top, 10)
    }
    
    // Toggle platform selection
    private func togglePlatformSelection(_ platform: Platform) {
        if selectedPlatforms.contains(platform) {
            selectedPlatforms.removeAll { $0 == platform }
        } else {
            selectedPlatforms.append(platform)
        }
    }
}

