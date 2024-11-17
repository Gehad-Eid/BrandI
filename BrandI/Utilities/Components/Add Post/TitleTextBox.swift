//
//  TitleTextBox.swift
//  Challange1
//
//  Created by Gehad Eid on 15/11/2024.
//

import SwiftUI

struct TitleTextBox: View {
    @Binding var title: String
//    @Binding var selectedTab: String
    var selectedTab: String? = nil
    
    var body: some View {
        Group {
            HStack {
                TextField("Title", text: $title)
                    .background(Color.clear)
                    .font(.title2)
                    .onChange(of: title) { newValue in
                        if title.count > 20 {
                            title = String(title.prefix(20))
                        }
                    }
                
                Spacer()
                
                Text("\(title.count)/20")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
            
            if selectedTab == "Add New Post" {
                Divider()
                    .background(Color.gray)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    TitleTextBox(title: .constant(""), selectedTab: nil)
}
