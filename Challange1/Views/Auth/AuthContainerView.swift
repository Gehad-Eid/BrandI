//
//  ContentView.swift
//  Challange1
//
//  Created by Gehad Eid on 01/10/2024.
//


import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct AuthContainerView: View {
    @State private var isSignUp: Bool = false
    @Binding var isAuthenticated: Bool
    
    @StateObject private var vm = AuthContainerViewModel()
    
    var body: some View {
        //        NavigationView {
        VStack {
            if isSignUp {
                SignUpView(isAuthenticated: $isAuthenticated)
            } else {
                SignInView(isAuthenticated: $isAuthenticated)
            }
            
            // Toggle between sign In and Up
            Button(action: {
                isSignUp.toggle()
            }) {
                Text(isSignUp ? "Already have an account? Sign In" : "Don't have an account? Sign Up")
                    .foregroundColor(.blue)
                    .padding()
            }
            
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)){
                Task {
                    do {
                        try await vm.signInWithGoogle()
                        isAuthenticated = true
                    }
                    catch {
                        print (error)
                    }
                }
            }
            
            // Sign in with apple
            Button(action: {
                Task {
                    do {
                        try await vm.signInWithApple()
                        isAuthenticated = true
                    }
                    catch {
                        print (error)
                    }
                }
            }, label: {
                SignInWithAppleButtonViewRepresentable(type: .signIn, style: .black)
                    .allowsTightening(false)
            })
            .frame(height: 55)
            
            
//            Spacer()
            
            
        }
        .padding()
    }
    //    }
}

#Preview {
    AuthContainerView(isAuthenticated: .constant(false))
}
