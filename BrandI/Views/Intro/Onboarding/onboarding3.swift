//
//  onboarding1.swift
//  Challange1
//
//  Created by sumaiya on 30/10/2567 BE.
//

import SwiftUI
import SDWebImageSwiftUI

struct onboarding3: View {
   
    var body: some View {
        ZStack{
            LinearGradient(
                colors: [Color.white, Color.babyBlue.opacity(0.7)],
                startPoint: .trailing,
                endPoint: .init(x:0, y: 0)
            )
            .edgesIgnoringSafeArea(.all)

            Image("Vector 318")
                .resizable()
                .frame(width: 40 , height: 40 )
                .padding(.leading,270)
                .padding(.top,20)
            Image("Vector 318")
                .resizable()
                .frame(width: 35 , height: 35)
                .padding(.leading,-140)
                .padding(.top,-280)
                
                
            VStack{
              Image("SiriGIF")
                    .resizable()
                    .frame(width: 142 , height: 255 )
                    .padding(.top,10)
                   
                
                
                Text("Create Content anytime\n anywhere with Siri")
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .padding(.top,50)
                   
            }
        } .edgesIgnoringSafeArea(.all)
        
            
    }
}

#Preview {
    onboarding3()
}
