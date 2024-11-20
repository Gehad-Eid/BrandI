//
//  BrandIdentityInputView.swift
//  BrandI
//
//  Created by Gehad Eid on 17/11/2024.
//

import SwiftUI

struct BrandIdentityInputView: View {
    var title: String
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.body)
            
            TextField(placeholder, text: $text)
                .padding()
                .background(Color.background)
                .cornerRadius(10)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(18)
    }
}
