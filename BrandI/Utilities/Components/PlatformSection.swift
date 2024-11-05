//
//  PlatformSection.swift
//  Challange1
//
//  Created by Gehad Eid on 26/10/2024.
//

import SwiftUI

struct PlatformSection: View {
    @State private var selectedDate: Date? = Date()
    @State private var isDatePickerPresented = false
    @State private var selectedPlatforms: [Platform] = []
    
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
        VStack(alignment: .leading, spacing: 15) {
            // Date selection section
            Text("Select Date")
                .font(.system(size: 18, weight: .semibold))
            
            Text(selectedDate != nil ? dateToString(selectedDate!) : "Select Date")
                .frame(width: 150, height: 40)
                .foregroundColor(selectedDate != nil ? .gray : .white)
                .background(selectedDate != nil ? Color.clear : Color("BabyBlue"))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .onTapGesture {
                    isDatePickerPresented = true
                }
                .sheet(isPresented: $isDatePickerPresented) {
                    VStack {
                        DatePicker(
                            "Select a date",
                            selection: Binding(
                                get: { selectedDate ?? Date() },
                                set: { selectedDate = $0 }
                            ),
                            displayedComponents: .date
                        )
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .labelsHidden()
                        
                        Button("Done") {
                            isDatePickerPresented = false
                        }
                        .padding()
                    }
                    .padding()
                }
            
            // Platform selection section
            Text("Select Your Platform")
                .font(.system(size: 18, weight: .semibold))
            
            HStack(spacing: 20) {
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
                            .frame(width: 50, height: 50)
                            .clipped()
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(/*isSelected ? Color.blue : */Color.clear, lineWidth: 2)
                            )
                    }
                }
            }
            .padding(.top, 5)
            
            BoostPerformanceButton()
                .padding(.top, 10)
        }
        .padding(.bottom, 20)
    }
    
    // Toggle platform selection
    private func togglePlatformSelection(_ platform: Platform) {
        if selectedPlatforms.contains(platform) {
            selectedPlatforms.removeAll { $0 == platform }
        } else {
            selectedPlatforms.append(platform)
        }
    }
    
    // Format date to string
    private func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

// Sample BoostPerformanceButton for layout purposes
struct BoostPerformanceButton: View {
    var body: some View {
        Button(action: {
            // Perform boost action
        }) {
            Text("✨ Boost Your Performance ✨")
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(10)
        }
    }
}

struct PlatformSection_Previews: PreviewProvider {
    static var previews: some View {
        PlatformSection()
    }
}
