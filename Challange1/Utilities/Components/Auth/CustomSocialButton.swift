//
//  CustomSocialButton.swift
//  Challange1
//
//  Created by Gehad Eid on 02/11/2024.
//

import SwiftUI

// Social Button Component
struct CustomSocialButton: View {
    var icon: String
    @Binding var isAuthenticated: Bool
    @ObservedObject var vm: AuthContainerViewModel
    
    var body: some View {
        Button(action: {
            Task {
                if icon.lowercased() == "google" {
                    try await vm.signInWithGoogle() {
                        isAuthenticated = true
                    }
                } else if icon.lowercased() == "apple" {
                    try await vm.signInWithApple() {
                        isAuthenticated = true
                    }
                }
            }
        }) {
            HStack {
                Image(icon)
                    .resizable()
                    .frame(width: 30,height: 30)
                
            }
            .frame(width: 130, height: 25)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
    }
}
