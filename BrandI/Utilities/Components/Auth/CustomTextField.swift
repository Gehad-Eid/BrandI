//
//  CustomTextField.swift
//  Challange1
//
//  Created by Gehad Eid on 02/11/2024.
//

import SwiftUI

//struct CustomTextField: View {
//    var placeholder: String
//    @Binding var text: String
//    
//    var body: some View {
//        TextField(placeholder, text: $text)
//            .padding()
//            .background(Color.clear)
//            .overlay(
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(Color.gray, lineWidth: 1)
//            )
//    }
//    
//}

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    @Binding var showError: String?
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(showError == nil ? Color.gray : Color.red, lineWidth: 1)
            )
    }
}



