//
//  OnboardingView.swift
//  Challange1
//
//  Created by Gehad Eid on 29/09/2024.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    
    @Binding var isFirstTimeUser: Bool

    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                onboarding1()
                    .tag(0)
                onboarding2()
                    .tag(1)
                onboarding3()
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always)) // Swipeable pages with page indicators
            .animation(.easeInOut, value: currentPage)

            // Button to move to the main content after the last page
            Button(action: {
                if currentPage == 2 {
//                    isOnboardingCompleted = true
                    completeOnboarding()
                } else {
                    currentPage += 1
                }
            }) {
                Text(currentPage == 2 ? "Get Started" : "   ")
                    .bold()
                    .padding()
                    .foregroundColor(.white)
                    .background(currentPage == 2 ? Color.blue : Color.clear)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
        }
        .padding()
    }
    
    private func completeOnboarding() {
        UserDefaults.standard.set(true, forKey: "isFirstTimeUser")
        isFirstTimeUser = false
    }
}

// A parent view for preview purposes
struct OnboardingViewWrapper: View {
    @State private var isFirstTimeUser = false
    
    var body: some View {
        OnboardingView(isFirstTimeUser: $isFirstTimeUser)
    }
}

#Preview {
    OnboardingViewWrapper()
}


