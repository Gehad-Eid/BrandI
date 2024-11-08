//
//  HeaderView.swift
//  Challange1
//
//  Created by Gehad Eid on 04/11/2024.
//


import SwiftUI

struct HeaderView: View {
    @Binding var showingAddPostView: Bool
    @Binding var isAuthenticated: Bool
    @State private var showSignInSheet = false

    var body: some View {
        HStack {
            Text("Agenda")
                .font(.system(size: 40, weight: .bold))
            
            Spacer()
            
            Button(action: {
                if isAuthenticated {
                    showingAddPostView.toggle()
                } else {
                    showSignInSheet = true
                }
            }) {
                Text("+")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color("Background"))
                    .frame(width: 30, height: 30)
                    .background(Color("BabyBlue"))
                    .cornerRadius(9)
            }
            .sheet(isPresented: $showingAddPostView) {
                CreatePostView(post: nil)
            }
            .sheet(isPresented: $showSignInSheet) {
                AuthContainerView(isAuthenticated: $isAuthenticated, showSignInSheet: $showSignInSheet)
            }
        }
    }
}
