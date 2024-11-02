////
////  SignIn.swift
////  Challange1
////
////  Created by sumaiya on 24/10/2567 BE.
////
//
//
//import SwiftUI
//
//
//struct SignIn: View {
//    @State private var fullName: String = ""
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var isPasswordVisible: Bool = false
//    @State private var isAgree: Bool = false
//    
//    var body: some View {
//        VStack(spacing: 16) {
//            Text("Sign in")
//                .font(.title)
//                .fontWeight(.bold)
//                .padding(.top, -30)
//            VStack(alignment: .leading,spacing: 14){
//             
//                Text("Email")
//                    .font(.caption)
//                    .foregroundColor(.black)
//                CustomTextField(placeholder: "", text: $email)
//                Text("Example@gmail.com")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//                
//                
//                Text("Password")
//                    .font(.caption)
//                    .foregroundColor(.black)
//                CustomSecureField(placeholder: "", text: $password, isPasswordVisible: $isPasswordVisible)
//                Text("Must be 8 characters")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//                
//            }
//        
//        
//            // Sign Up Button
//            Button(action: {
//                // Action for signing up
//            }) {
//                Text("Log in")
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color("BabyBlue"))
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//            
//            // Divider with "Or Sign in with"
//            HStack {
//                Text("")
//                   
//                
//                Text("Or Sign in with")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//                
//                Text("")
//            }
//            .padding(.vertical)
//            
//            // Apple and Gmail Sign In Buttons
//            HStack(spacing: 16) {
//                CustomSocialButton(icon: "Apple" )
//                CustomSocialButton(icon: "Google")
//            }
//            HStack {
//                Text("Don’t have an account? ")
//                    .foregroundColor(.gray)
//
//                Button(action: {
//                    // Log in action here
//                }) {
//                    Text("Sign up")
//                        .foregroundColor(Color("BabyBlue"))
//                       
//                }
//            }.padding(.top,10)
//        }
//        .padding(.vertical,8)
//        .padding(.horizontal,20)
//    }
//}
//
//
//
//
//
//
//#Preview {
//    SignIn()
//}
