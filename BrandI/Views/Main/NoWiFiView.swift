//
//  NoWiFiView.swift
//  BrandI
//
//  Created by Gehad Eid on 20/11/2024.
//

import SwiftUI

struct NoWiFiView: View {
    var onRetry: () -> Void // Callback for retry action
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "wifi.slash")
                .font(.system(size: 72))
                .foregroundStyle(Color.text)
            
            Text("No internet connection.")
                .font(.headline)
                .foregroundStyle(Color.text)
                .multilineTextAlignment(.center)
            
            Text("Please check ypur internet connection and try again.")
                .font(.caption)
                .foregroundStyle(Color.text)
                .multilineTextAlignment(.center)
            
            Button(action: onRetry) {
                Text("Try Again")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("BabyBlue"))
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
        }
        .padding()
    }
}
