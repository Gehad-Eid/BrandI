//
//  onboarding1.swift
//  Challange1
//
//  Created by sumaiya on 30/10/2567 BE.
//

import SwiftUI
import SDWebImageSwiftUI

struct onboarding2: View {
   
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
                .frame(width: 30 , height: 30 )
                //.padding(.leading,270)
                .padding(.leading,-170)
                .padding(.top,210)
            Image("Vector 318")
                .resizable()
                .frame(width: 40 , height: 40)
                .padding(.leading,270)
                .padding(.top,-280)
                
            VStack{
                Image("postGIF")
                    .resizable()
                    .frame(width:300,height:250)
                    .padding(.bottom,90)
                   
                
                
                Text("Post and schedule across \n multiple platforms")
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .lineLimit(2)
                   
            }
        } .edgesIgnoringSafeArea(.all)
            
    }
}

#Preview {
    onboarding2()
}
