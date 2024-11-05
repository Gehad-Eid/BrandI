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
      var description: String
      var destination: AnyView

      @Environment(\.colorScheme) var colorScheme

      var body: some View {
          NavigationLink(destination: destination) {
              VStack(spacing: 0) {
                  // Title & Platforms
                HStack {
                    Text(title)
                        .foregroundStyle(Color("Text"))
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
                .background(Color("BoxColor"))
                .clipShape(TopCornersRoundedRectangle(radius: 18))
                .shadow(color: Color.black.opacity(0.9), radius: 1, x: 0.4, y: 0.4)

                // Details
                VStack(alignment: .leading) {
                    HStack {
                        Text(description)
                            .foregroundColor(Color("GrayText"))
                            .padding(.top, 16)
                            .padding(.leading, 16)
                        Spacer()
                    }
                    Spacer()
                }
                .frame(width: 330, height: 153)
                .background(Color("BabyBlue"))
                .clipShape(BottomCornersRoundedRectangle(radius: 18))
                .shadow(color: Color.black.opacity(0.3), radius: 0.1, x: 0.5, y: 0.5)
            }
        }
    }
}


#Preview {
    NavigationStack {
        ReusableCardView(title: "plapladfghjkjhnbgvfcdfvgbhjkjhbgvfcpla", platforms: [.instagram,.linkedin, .tiktok, .twitter], description: "", destination: AnyView(Text("dfghj")))
    }
}
