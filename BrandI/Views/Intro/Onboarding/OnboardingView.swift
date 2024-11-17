//
//  OnboardingView.swift
//  Challange1
//
//  Created by Gehad Eid on 29/09/2024.
//

import SwiftUI

//TODO: Skip button
//TODO: view instead of images

struct OnboardingView: View {
    @State private var currentPage = 0
    @Binding var isFirstTimeUser: Bool
    
    var body: some View {
        VStack {
            // Onboarding TabView
            TabView(selection: $currentPage) {
                onboarding1()
                    .tag(0)
                onboarding2()
                    .tag(1)
                onboarding3()
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentPage)
            .edgesIgnoringSafeArea(.all)
            
            // Custom Progress Indicator
            HStack(spacing: 8) {
                ForEach(0..<3) { index in
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(currentPage == index ? .babyBlue : .gray)
                        .scaleEffect(currentPage == index ? 1.2 : 1.0)
                        .animation(.easeInOut, value: currentPage)
                }
            }
            .padding(.bottom, 20)
            
            // Button to navigate to main content or next page
            Button(action: {
                if currentPage == 2 {
                    completeOnboarding()
                } else {
                    currentPage += 1
                }
            }) {
                Text(currentPage == 2 ? "Get Started" : "Next")
                    .bold()
                    .padding()
                    .foregroundColor(.white)
                    .background(currentPage == 2 ? Color("BabyBlue") : Color.clear)
                    .cornerRadius(10)
            }
            .padding(.bottom, 50)
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
    
    private func completeOnboarding() {
        UserDefaults.standard.set(true, forKey: "isFirstTimeUser")
        isFirstTimeUser = false
    }
}

// Preview setup
struct OnboardingViewWrapper: View {
    @State private var isFirstTimeUser = false
    
    var body: some View {
        OnboardingView(isFirstTimeUser: $isFirstTimeUser)
            .ignoresSafeArea()
    }
}

#Preview {
    OnboardingViewWrapper()
}
