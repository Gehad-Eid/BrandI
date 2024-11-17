//
//  ContentTextBox.swift
//  Challange1
//
//  Created by Gehad Eid on 15/11/2024.
//

import SwiftUI

struct ContentTextBox: View {
    @Binding var content: String
    
    var body: some View {
        VStack {
            TextField("Write your content here", text: $content, axis: .vertical)
                .padding(.vertical, 12)
                .lineLimit(7)
                .frame(height: 200, alignment: .top)
                .onChange(of: content) { newValue in
                    if content.count > 300 {
                        content = String(content.prefix(300))
                    }
                }
            
            Spacer()
            HStack {
                Spacer()
                Text("\(content.count)/300")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
        }
    }
}

#Preview {
    ContentTextBox(content: .constant(""))
}
