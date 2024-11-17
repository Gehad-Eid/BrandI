//
//  DraftSection.swift
//  Challange1
//
//  Created by sumaiya on 17/11/2567 BE.
//

import SwiftUI

struct DraftSection: View {
    var body: some View {
           NavigationView {
               HStack {
                   Text("Draft")
                       .font(.headline)
                       .foregroundColor(.black)
                   
                   Spacer()
                   
                   NavigationLink(destination: DraftView()) {
                       Image(systemName: "chevron.right")
                           .font(.title2)
                           .foregroundColor(.black)
                   }
               }
               .padding()
               .background(Color("graybackground"))
               .cornerRadius(10)
               .padding(.horizontal)
               
           }
       }
}
//The View
struct DraftView: View {
    var body: some View {
        Text("Welcome to Draft View!")
            .font(.title)
            .padding()
    }
}

#Preview {
    DraftSection()
}
