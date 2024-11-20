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
                       .fontWeight(.medium)
                       .foregroundColor(Color("Text"))
                   
                   Spacer()
                   
                   Image(systemName: "chevron.right")
                       .font(.body)
                       .fontWeight(.medium)
                       .foregroundColor(Color("Text"))
               }
               .padding(.horizontal, 10)
               .padding(.vertical, 10)
               .background(Color("DraftBackground"))
               .cornerRadius(15)
           }
           .padding(.bottom, 10)  
       }
   }

#Preview {
    DraftSection(items: [])
}
