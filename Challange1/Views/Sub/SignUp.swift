////
////  SignUp.swift
////  Challange1
////
////  Created by sumaiya on 24/10/2567 BE.
////
//
//import SwiftUI
//
//
//
//struct SignUp: View {
//    @State private var fullName: String = ""
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var isPasswordVisible: Bool = false
//    @State private var isAgree: Bool = false
//    
//    var body: some View {
//         
//        VStack(spacing: 16) {
//            Text("Sign up")
//                .font(.title)
//                .fontWeight(.bold)
//                .padding(.top, -30)
//            VStack(alignment: .leading,spacing: 14){
//                Text("Full Name")
//                    .font(.caption)
//                    .foregroundColor(.black)
//                CustomTextField(placeholder: "", text: $fullName)
//                
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
//            HStack {
//                Button(action: {
//                    isAgree.toggle()
//                }) {
//                    Image(systemName: isAgree ? "checkmark.square" : "square")
//                        .foregroundColor(.gray)
//                        .cornerRadius(8)
//                }
//                Text("I agree with terms and conditions and privacy policy")
//                    .font(.caption)
//            }
//            
//            // Sign Up Button
//            Button(action: {
//                // Action to handle sign-up
//                Task {
//                    do {
//                        try await vm.signUp()
//                        isAuthenticated = true
//                    } catch {
//                        print("Error: \(error)")
//                    }
//                }
//            }) {
//                Text("Sign Up")
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
//                Text("Already have an account? ")
//                    .foregroundColor(.gray)
//
//                Button(action: {
//                    // Log in action here
//                }) {
//                    Text("Log in")
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
//struct CustomTextField: View {
//    var placeholder: String
//    @Binding var text: String
//    
//    var body: some View {
//        TextField(placeholder, text: $text)
//            .padding()
//            .background(Color.clear)
//            .overlay(
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(Color.gray, lineWidth: 1)
//            )
//    }
//
//}
//
////PasswordField Component
//struct CustomSecureField: View {
//    var placeholder: String
//    @Binding var text: String
//    @Binding var isPasswordVisible: Bool
//    
//    var body: some View {
//        HStack {
//            if isPasswordVisible {
//                TextField(placeholder, text: $text)
//            } else {
//                SecureField(placeholder, text: $text)
//            }
//            Button(action: {
//                isPasswordVisible.toggle()
//            }) {
//                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
//                    .foregroundColor(.gray)
//            }
//        }
//        .padding()
//        .background(Color.clear)
//        .overlay(
//            RoundedRectangle(cornerRadius: 8)
//                .stroke(Color.gray, lineWidth: 1)
//        )
//    }
//}
//
//// Social Button Component
//struct CustomSocialButton: View {
//    var icon: String
//   
//    
//    var body: some View {
//        Button(action: {
//            // Social button action
//        }) {
//            HStack {
//                Image(icon)
//                    .resizable()
//                    .frame(width: 30,height: 30)
//                
//            }
//            .frame(width: 130, height: 25)
//            .padding()
//            .overlay(
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(Color.gray, lineWidth: 1)
//            )
//        }
//    }
//}
//
//
//#Preview {
//    SignUp()
//}
