//
//  UploadButtonSection.swift
//  BrandI
//
//  Created by Gehad Eid on 17/11/2024.
//


import SwiftUI

struct UploadButtonSection: View {
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var brandVM: BrandIdintityViewModel
    let updateBrand: ([BarandIdentity]) async throws -> Void
    let onDone: (() -> Void)?
    
    @State var isDonePressed: Bool = false
    
    var body: some View {
        Button(action: {
            if let _ = brandVM.selectedImage {
                isDonePressed = true
                Task {
                    await brandVM.handleImageUploadAndSave(updateBrand: updateBrand){
                        // Call `onDone` only if it's provided
                        if let onDone = onDone {
                            onDone()
                        }
                        else {
                            dismiss()
                        }
                    }
                }
            }
        }) {
            HStack {
                Spacer()
                Text(isDonePressed ? "Processing..." : "Done")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding()
            .frame(height: 50)
            .background(isDonePressed ? .gray : Color("BabyBlue"))
            .cornerRadius(10)
        }
        .disabled(isDonePressed)
        .padding(.vertical)
    }
}
