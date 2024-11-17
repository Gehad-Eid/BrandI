//
//  CustomProgressBarAutomatically.swift
//  BrandI
//
//  Created by sumaiya on 24/10/2567 BE.
//

import SwiftUI

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
