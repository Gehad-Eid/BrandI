//
//  OnboardingPageView.swift
//  Challange1
//
//  Created by Gehad Eid on 19/10/2024.
//

import SwiftUI

struct OnboardingPageView: View {
    let imageName: String
    let title: String
    let description: String

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()

            Text(title)
                .font(.title)
                .bold()
                .padding(.top, 20)

            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.top, 10)
        }
    }
}
