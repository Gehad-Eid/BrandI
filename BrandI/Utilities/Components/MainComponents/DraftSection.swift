//
//  DraftSection.swift
//  Challange1
//
//  Created by sumaiya on 17/11/2567 BE.
//

import SwiftUI

struct DraftSection: View {
    let items: [Post]
    
    var body: some View {
        NavigationLink(destination: ItemScrollView(items: items, type: "drafts")) {
            HStack {
                Text("Draft")
                    .font(.body)
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.body)
                    .foregroundColor(.black)
            }
            .padding()
            .background(Color("graybackground"))
            .cornerRadius(15)
            .padding(.horizontal)
        }
    }
}



#Preview {
    DraftSection(items: [])
}
