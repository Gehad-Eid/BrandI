//
//  PopUpAi.swift
//  Challange1
//
//  Created by sumaiya on 24/10/2567 BE.
//

import SwiftUI

import SwiftUI

struct PopUpAi: View {
    @State private var progress: CGFloat = 0.4
    @State private var progress1: Double = 0.5
    @State private var progress2: Double = 0.75
    @State private var progress3: Double = 0.75

    var body: some View {
     
        VStack(alignment: .leading) {
            HStack {
                CustomProgressBar(progress: $progress)
                Text("\(Int(progress * 100))%")
            }
            //TextView After the loading will goes here
            VStack(alignment: .leading) {
                CustomProgressBarAutomatically(progress: $progress1, width: 285)
                CustomProgressBarAutomatically(progress: $progress2, width: 285)
                CustomProgressBarAutomatically(progress: $progress3, width: 200)
            }
            .onAppear {
                withAnimation {
                    self.progress1 = 1.0
                    self.progress2 = 1.0
                    self.progress3 = 1.0
                }
            }
            Button(action: {
                print("Done Button Pressed")
            }) {
                Text("Done")
                    .frame(width: 315, height: 35)
                    .background(Color("BabyBlue"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }.padding(.top, 30)

           
        }
        .frame(width: 315, height: 230)
        .padding()
        .background(Color("Background"))
        .cornerRadius(18)
        .padding()
    }
}
    


struct CustomProgressBar: View {
    @Binding var progress: CGFloat //  0.0 to 1.0
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 20)
                    .foregroundColor(Color("ProgressBackground"))
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: progress * 300, height: 20)
                    .foregroundColor(Color("BabyBlue"))
                    .animation(.easeInOut(duration: 0.5), value: progress) // Animation
            }
            
        }
    }
}

struct CustomProgressBarAutomatically: View {
    @Binding var progress: Double
    var width: CGFloat
    var gradientColors: [Color] = [Color.gridColor1, Color.gridColor2]

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: width, height: 20)
                .foregroundColor(Color.clear)
            
            LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .trailing, endPoint: .leading)
                .frame(width: width * CGFloat(progress), height: 20)
                .cornerRadius(10)
                .animation(.smooth(duration: 1).repeatForever(autoreverses: true))
        }
    }
}

#Preview {
    PopUpAi()
}


//TextView After the loading
