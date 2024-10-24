//
//  PasswordChangeView.swift
//  Challange1
//
//  Created by sumaiya on 24/10/2567 BE.
//

import SwiftUI



struct PasswordChangeView: View {
    @State private var oldPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    
    @State private var isOldPasswordHidden: Bool = true
    @State private var isNewPasswordHidden: Bool = true
    @State private var isConfirmPasswordHidden: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Old Password TextField
            Text("Old Password")
                .font(.headline)
            ZStack {
                if isOldPasswordHidden {
                    SecureField("", text: $oldPassword)
                } else {
                    TextField("Enter old password", text: $oldPassword)
                }
                HStack {
                    Spacer()
                    Button(action: {
                        isOldPasswordHidden.toggle()
                    }) {
                        Image(systemName: isOldPasswordHidden ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.trailing, 10)
            }
            .padding()
            .background(Color.background)
            .cornerRadius(10)

            // New Password TextField
            Text("New Password")
                .font(.headline)
            ZStack {
                if isNewPasswordHidden {
                    SecureField("", text: $newPassword)
                } else {
                    TextField("", text: $newPassword)
                }
                HStack {
                    Spacer()
                    Button(action: {
                        isNewPasswordHidden.toggle()
                    }) {
                        Image(systemName: isNewPasswordHidden ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.trailing, 10)
            }
            .padding()
            .background(Color.background)
            .cornerRadius(10)

            // Confirm New Password TextField
            Text("Confirm New Password")
                .font(.headline)
            ZStack {
                if isConfirmPasswordHidden {
                    SecureField("", text: $confirmPassword)
                } else {
                    TextField("", text: $confirmPassword)
                }
                HStack {
                    Spacer()
                    Button(action: {
                        isConfirmPasswordHidden.toggle()
                    }) {
                        Image(systemName: isConfirmPasswordHidden ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.trailing, 10)
            }
            .padding()
            .background(Color.background)
            .cornerRadius(10)
            
         
            Spacer()
            Button(action: {
                
            }) {
                Text("Change Password")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.babyBlue)
                    .cornerRadius(10)
            }

        }
        .padding()
    }
}

struct PasswordChangeView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordChangeView()
    }
}
