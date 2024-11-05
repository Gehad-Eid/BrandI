//
//  IntegrationView.swift
//  Challange1
//
//  Created by sumaiya on 01/11/2567 BE.
//

import SwiftUI

struct IntegrationView: View {
    var body: some View {
        VStack{
            Text("Linked accounts")
                .font(.title)
                .foregroundColor(.primary)
            
        } .padding(.top, -330)
            VStack(spacing: 16) {
                
                IntegrationViewCompnents(icon: Image("Intagram icon Light"), labelText: "Instagram")
                IntegrationViewCompnents(icon: Image("Tiktok icon Light"), labelText: "TikTok")
                
            }
            .padding()
            .padding(.top, -290)
        }
    
}

struct IntegrationViewCompnents: View {
    @State private var isConnected: Bool = false
    
    var icon: Image
    var labelText: String
    
    var body: some View {

        HStack(spacing: 16) {
            icon
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
            
            Text(labelText)
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
            
            Button(action: {
                isConnected.toggle()
            }) {
                Text(isConnected ? "Disconnect" : "Connect")
                    .foregroundColor(isConnected ? .red : .gray)
                    .padding(.vertical, 3)
                    .padding(.horizontal, 16)
                  
            }
        }
        .padding()
        .background(Color("BoxColor"))
        .cornerRadius(9)
    }
}

#Preview {
    IntegrationView()
}

#Preview {
    IntegrationViewCompnents(icon: Image(systemName: "bell.fill"), labelText: "Notifications")
}
