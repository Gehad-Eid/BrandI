//
//  BrandInputSection.swift
//  BrandI
//
//  Created by Gehad Eid on 17/11/2024.
//


import SwiftUI

struct BrandInputSection: View {
    @ObservedObject var brandVM: BrandIdintityViewModel
    let categories: [String]
    @Binding var showImagePicker: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            BrandIdentityInputView(
                title: "What's your brand name",
                placeholder: "Your brand name",
                text: $brandVM.nameText
            )

            BrandIdentityInputView(
                title: "Describe your brand purpose",
                placeholder: "Your mission, vision, and values",
                text: $brandVM.identityText
            )

            VStack(alignment: .leading, spacing: 10) {
                Text("Select your brand category")
                    .font(.body)

                HStack {
                    Picker("Category", selection: $brandVM.selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    Spacer()
                }
                .background(Color.background)
                .cornerRadius(10)
            }
            .pickerStyle(MenuPickerStyle())

            BrandIdentityInputView(
                title: "Who is your audience",
                placeholder: "Your target audience",
                text: $brandVM.audianceText
            )
        }
    }
}