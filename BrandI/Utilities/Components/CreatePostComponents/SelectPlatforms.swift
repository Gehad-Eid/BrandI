//
//  SelectPlatforms.swift
//  Challange1
//
//  Created by Gehad Eid on 26/10/2024.
//

import SwiftUI

struct SelectPlatforms: View {
    @Binding var selectedPlatforms: [Platform]
    @Binding var isEditingEnabled: Bool
    
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
        Text("Select Your Platform")
            .font(.system(size: 18, weight: .medium))
        
        HStack(alignment: .center, spacing: 20) {
            // Show only selected platforms when not editing, or all platforms if editing
            ForEach(platformList.indices, id: \.self) { index in
                let platform = platformList[index]
                let isSelected = selectedPlatforms.contains(platform)
                
                if isEditingEnabled || isSelected {
                    let iconName = isSelected ? selectedImages[index] : images[index]
                    
                    Button(action: {
                        if isEditingEnabled {
                            togglePlatformSelection(platform)
                        }
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
                }
            }
        }
        .padding()
  
        .frame(width: 362, height: 66)
        .background(Color("graybackground"))
        .cornerRadius(18)
        
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

