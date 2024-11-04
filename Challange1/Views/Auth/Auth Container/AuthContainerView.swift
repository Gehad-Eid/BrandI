//
//  ContentView.swift
//  Challange1
//
//  Created by Gehad Eid on 01/10/2024.
//


import SwiftUI

struct AuthContainerView: View {
    @State private var isSignUp: Bool = false
    @Binding var isAuthenticated: Bool
    
    @StateObject private var vm = AuthContainerViewModel()
    
    var body: some View {
        ScrollView {
            if isSignUp {
                SignUpView(isAuthenticated: $isAuthenticated)
            } else {
                SignInView(isAuthenticated: $isAuthenticated)
            }
            
            // Apple and Gmail Sign In Buttons
            VStack {
                HStack(spacing: 16) {
                    CustomSocialButton(icon: "Apple", isAuthenticated: $isAuthenticated, vm: vm)
                    CustomSocialButton(icon: "Google", isAuthenticated: $isAuthenticated, vm: vm)
                }
                
                if let errorMessage = vm.errorMessage {
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            
            // Toggle between sign In and Up
            HStack {
                Text(isSignUp ? "Already have an account?" : "Don't have an account?")
                    .foregroundColor(.gray)
                
                Button(action: {
                    isSignUp.toggle()
                }) {
                    Text(isSignUp ? "Log in" : "Sign Up")
                        .foregroundColor(Color("BabyBlue"))
                    
                }
            }.padding(.top,10)
        }
    }
}

#Preview {
    AuthContainerView(isAuthenticated: .constant(false))
}
