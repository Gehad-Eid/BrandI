//
//  EditViewComponent.swift
//  BrandI
//
//  Created by Gehad Eid on 16/11/2024.
//


import SwiftUI

struct EditViewComponent<Content: View>: View {
    var title: String
    var content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.headline.weight(.medium))
            
            HStack {
                content()
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
        }
        .padding(.top, 10)
    }
}

#Preview {
    EditViewComponent(title: "title") {
        Text("content for post")
            .foregroundColor(.blue)
    }
}

