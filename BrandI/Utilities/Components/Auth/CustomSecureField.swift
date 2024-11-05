//
//  CustomSecureField.swift
//  Challange1
//
//  Created by Gehad Eid on 02/11/2024.
//

import SwiftUI

//PasswordField Component
struct CustomSecureField: View {
    var placeholder: String
    @Binding var text: String
    @Binding var isPasswordVisible: Bool
    @Binding var showError: String?
    
    var body: some View {
        HStack {
            if isPasswordVisible {
                TextField(placeholder, text: $text)
            } else {
                SecureField(placeholder, text: $text)
            }
            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.clear)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(showError == nil ? Color.gray : Color.red, lineWidth: 1)
        )
    }
}

//struct CustomSecureField: View {
//    var placeholder: String
//    @Binding var text: String
//    @Binding var isPasswordVisible: Bool
//    
//    var body: some View {
//        HStack {
//            if isPasswordVisible {
//                TextField(placeholder, text: $text)
//            } else {
//                SecureField(placeholder, text: $text)
//            }
//            Button(action: {
//                isPasswordVisible.toggle()
//            }) {
//                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
//                    .foregroundColor(.gray)
//            }
//        }
//        .padding()
//        .background(Color.clear)
//        .overlay(
//            RoundedRectangle(cornerRadius: 8)
//                .stroke(Color.gray, lineWidth: 1)
//        )
//    }
//}
