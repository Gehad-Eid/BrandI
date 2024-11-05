//
//  orDivider.swift
//  Challange1
//
//  Created by Gehad Eid on 03/11/2024.
//

import SwiftUICore

struct orDivider: View {
    var text: String
    
    var body: some View {
        HStack {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
            
            Text("Or \(text)")
                .font(.caption)
                .foregroundColor(.gray)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
        }
        .padding(.vertical)
    }
}
