//
//  MainView.swift
//  Challange1
//
//  Created by sumaiya on 21/10/2567 BE.
//

import SwiftUI

struct MainView: View {
    @State private var isButtonOn = true
    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        Text("Agenda")
                            .font(.system(size: 40, weight: .bold))
                        Spacer()
                        
                        // NavigationLink for button click
                        NavigationLink(destination: CreatePostView()) {
                            Text("+")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                .background(Color("BabyBlue"))
                                .cornerRadius(6.0)
                                .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 4) // Add shadow
                                .multilineTextAlignment(.center) // Center the text
                        }
                        
                    }
                    
                    AppBar()
                        .padding(.top, -15)
                    UpcomingSection()
                        .padding(.top, 10)
                  
                    CardViewSection()
                        .padding(.top, 5)
                }
                .padding(.horizontal, 20)
            }
           
        }
    }
}

#Preview {
    MainView()
}
