//
//  onboarding1.swift
//  Challange1
//
//  Created by sumaiya on 30/10/2567 BE.
//

import SwiftUI
import SDWebImageSwiftUI

struct onboarding1: View {
   
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
                .padding(.top,400)
            Image("Vector 318")
                .resizable()
                .frame(width: 35 , height: 35)
                .padding(.leading,-140)
                .padding(.top,-280)
                
                
            VStack(alignment: .center){
                AnimatedImage(name:"AI.gif")
                    .resizable()
                    .frame(width: 250 , height: 200 )
                    .padding(.bottom,60)
                    .padding(.trailing,50)
                   
                
                
                Text("Create consistent  content \n with our AI powered brand \n analysis")
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .lineLimit(3)
                   
            }
        } .edgesIgnoringSafeArea(.all)
        
            
        
            
    }
}

#Preview {
    onboarding1()
}
