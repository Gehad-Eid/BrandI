//
//  Splash2.swift
//  Challange1
//
//  Created by sumaiya on 04/11/2567 BE.
//


import SwiftUI

struct Splash2: View {
    @State private var offset: CGFloat = -UIScreen.main.bounds.height / 800
    @State private var showTextAnimation: Bool = false
    @State private var showBackground: Bool = false
    
    var body: some View {
        ZStack {
            if showBackground {
                Background1()
            } else {
                Color("BabyBlue")
                    .ignoresSafeArea()
            }
            
            if showTextAnimation {
                TextAnimation()
                    .transition(.opacity)
            }
            
            let opacity = min(max(1.7 - (offset / 400), 0), 1)
            
            ZStack {
                Rectangle()
                    .fill(Color("R1"))
                    .frame(width: .infinity, height: 400)
                    .cornerRadius(40)
                    .shadow(color: .black.opacity(0.5), radius: 20, x: 0, y: 10)
                    .offset(y: offset - 80)
                    .opacity(opacity)
            }
            
            Rectangle()
                .fill(Color("R2"))
                .frame(height: 250)
                .cornerRadius(40)
                .shadow(color: .black.opacity(0.5), radius: 20, x: 0, y: 10)
                .offset(y: offset - 80)
                .opacity(opacity)
            
            Rectangle()
                .fill(Color("R3"))
                .frame(height: 550)
                .cornerRadius(40)
                .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 10)
                .offset(y: offset + 45)
                .padding(.bottom, -200)
                .opacity(opacity)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.3)) {
                offset = UIScreen.main.bounds.height - 600
                showTextAnimation = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeInOut(duration: 4)) {
                    offset += 400
                   
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        showBackground = true
                    }
                    
                    // Hide the text animation after the background appears
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        //withAnimation {
                            showTextAnimation = false
                        //}
                    }
                }
            }
        }
    }
}

struct Splash2_Previews: PreviewProvider {
    static var previews: some View {
        Splash2()
    }
}



struct TextAnimation: View {
    @State private var opacity: Double = 0.5
    @State private var spacing: CGFloat = 20

    var body: some View {
        ZStack(alignment: .center){

            // HStack for Brand and Vector Images
            HStack(spacing: spacing) {
                Image("Brand")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170, height: 50)
                    .opacity(opacity)

                Image("Vector3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 62, height: 62)
                    .padding(.top, -20)
                    .padding(.leading, -30)
                    .opacity(opacity)
            }.padding(.trailing,-30)
        }
        .onAppear {
            // Animate the opacity and spacing
            withAnimation(.easeInOut(duration: 3)) {
                opacity = 1.0
                spacing = 0
            }
        }
    }
}

#Preview {
    TextAnimation()
}

struct Background1:View {
    @State private var starShake1: CGFloat = 0
    @State private var starShake2: CGFloat = 0
    @State private var starShake3: CGFloat = 0
    @State private var starShake4: CGFloat = 0
    @State private var starShake5: CGFloat = 0
    
    var body: some View {
        
        ZStack{
            
            Image("Spladh screen1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            // HStack for Brand and Vector Images
            HStack() {
               
                    
                Image("Brand2")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170, height: 50)
                   
             
                
                
                
                Image("Vector4")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 62, height: 62)
                    .padding(.top, -20)
                    .padding(.leading, -33)
                   

                
            }.padding(.trailing,-30)
                
            
            
            Image("starB")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            //.offset(x: 70, y: -80)
                .offset(x: 70 + starShake1, y: -80)
            
            
            
            Image("satrB")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            //.offset(x: -120, y: -260)
                .offset(x: -120 + starShake2, y: -260)
            Image("satrB")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .offset(x: 120 + starShake3, y: -200)
            //Down Starts
            Image("satrB")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .offset(x: -100 + starShake4, y: 190)
            Image("satrB")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .offset(x: 120 + starShake5, y: 100)
            
            
            
        }
        .onAppear {
           
            withAnimation(Animation.spring(duration: 1).repeatForever(autoreverses: true)) {
                starShake1 = 5
                starShake2 = -5
                starShake3 = 5
                starShake4 = -5
                starShake5 = 5
            }
        }
    }
}
#Preview {
    Background1()
}
