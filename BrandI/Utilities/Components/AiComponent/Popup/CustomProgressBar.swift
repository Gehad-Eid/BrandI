//
//  CustomProgressBar.swift
//  BrandI
//
//  Created by sumaiya on 24/10/2567 BE.
//

import SwiftUI

struct CustomProgressBar: View {
    @Binding var progress: CGFloat //  0.0 to 1.0
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 15)
                    .foregroundColor(Color("ProgressBackground"))
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: progress * 280, height: 15)
                    .foregroundColor(Color("BabyBlue"))
                    .animation(.easeInOut(duration: 0.5), value: progress)
            }
        }
    }
}
