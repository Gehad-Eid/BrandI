//
//  FullScreenImageCarousel.swift
//  BrandI
//
//  Created by Gehad Eid on 15/11/2024.
//

import SwiftUI

struct FullScreenImageCarousel: View {
    let images: [UIImage]
    @Binding var currentIndex: Int
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            // Background
            Color.gray.ignoresSafeArea()
            
            // Images
            TabView(selection: $currentIndex) {
                ForEach(images.indices, id: \.self) { index in
                    Image(uiImage: images[index])
                        .resizable()
                        .scaledToFit()
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
            // Close Button
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark.app.fill")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                        //TODO: make background white with nothing out
                            .background(Color.white)
                            .cornerRadius(20)
                            .padding()
                    }
                }
                Spacer()
            }
        }
    }
}
