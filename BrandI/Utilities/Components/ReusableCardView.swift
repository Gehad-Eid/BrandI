//
//  ReusableCardView.swift
//  Challange1
//
//  Created by Gehad Eid on 26/10/2024.
//

import SwiftUI

struct ReusableCardView: View {
    var title: String
    var platforms: [Platform]
    var selectedImages: [ImageData]
    var description: String
    var destination: AnyView
    
    @State var showingPostView: Bool = false
    
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 0) {
            // Title & Platforms
            HStack {
                Text(title)
                    .foregroundStyle(Color.white)
                    .fontWeight(.semibold)
                    .padding()
                Spacer()
                HStack {
                    ForEach(platforms.prefix(3), id: \.self) { platform in
                        Image(platform.iconName(for: colorScheme))
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }
                .padding()
            }
            .frame(width: 330, height: 47)
            .background(Color("BabyBlue"))
            .clipShape(TopCornersRoundedRectangle(radius: 18))
            .shadow(color: Color.black.opacity(0.9), radius: 1, x: 0.4, y: 0.4)
            
            // Details
            VStack(alignment: .leading) {
                HStack {
                    Text(description)
                        .foregroundColor(Color("Text"))
                        .padding(.top, 16)
                        .padding(.leading, 16)
                    Spacer()
                }
                
                Spacer()
                
                HStack{
                    Spacer()
                    
                    ZStack {
                        if !selectedImages.isEmpty {
                            ForEach(selectedImages.indices, id: \.self) { index in
                                AsyncImage(url: URL(string: selectedImages[index].imageUrl)){ image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 40, height: 40)
                                        .clipped()
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.gray, lineWidth: 0.5)
                                        )
                                    // Stacked effect: Increase x-offset to make images overlap
                                        .offset(x: CGFloat((index * (5))), y: 10)
                                        .zIndex(Double(index + 1))
                                    
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 40, height: 40)
                                        .clipped()
                                        .cornerRadius(8)
                                        .zIndex(Double(index + 1))
                                }
                            }
                            
                            Text("\(selectedImages.count)+")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                                .padding(3)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.gray.opacity(0.9))
                                )
                                .offset(x: 20, y: 10)
                                .zIndex(100)
                        }
                    }
                    .frame(width: 40, height: 40)
                    .padding(.bottom, 10)
                }
                .padding(.trailing,30)
                .padding(.bottom,10)
            }
            .frame(width: 330, height: 153)
            .background(Color("BoxColor2"))
            .clipShape(BottomCornersRoundedRectangle(radius: 18))
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 2, y: 2)
        }
        .onTapGesture {
            showingPostView = true
        }
        .fullScreenCover(isPresented: $showingPostView){
            destination
        }
    }
}
