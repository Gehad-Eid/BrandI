//
//  UploadButtonSection.swift
//  BrandI
//
//  Created by Gehad Eid on 17/11/2024.
//


import SwiftUI

struct UploadButtonSection: View {
    @ObservedObject var brandVM: BrandIdintityViewModel
    let updateBrand: ([BarandIdentity]) async throws -> Void

    var body: some View {
        Button(action: {
            if let _ = brandVM.selectedImage {
                Task {
                    await brandVM.handleImageUploadAndSave(updateBrand: updateBrand)
                }
            }
        }) {
            HStack {
                Spacer()
                Text("Done")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding()
            .frame(height: 50)
            .background(Color("BabyBlue"))
            .cornerRadius(10)
        }
        .padding(.vertical)
    }
}