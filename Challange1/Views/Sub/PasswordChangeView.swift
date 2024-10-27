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

    @ObservedObject var vm: SettingsViewModel

    @State private var isOldPasswordHidden: Bool = true
    @State private var isNewPasswordHidden: Bool = true
    @State private var isConfirmPasswordHidden: Bool = true
    @State private var oldPasswordError: String = ""
    @State private var newPasswordError: String = ""
    @State private var updateSuccessMessage: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            passwordField("Old Password", text: $oldPassword, isHidden: $isOldPasswordHidden, errorMessage: $oldPasswordError)
            passwordField("New Password", text: $newPassword, isHidden: $isNewPasswordHidden, errorMessage: $newPasswordError)
            passwordField("Confirm New Password", text: $confirmPassword, isHidden: $isConfirmPasswordHidden, errorMessage: nil)

            changePasswordButton()

            // Display success message if update is successful
            if !updateSuccessMessage.isEmpty {
                Text(updateSuccessMessage)
                    .foregroundColor(.green)
                    .font(.headline)
            }

            Spacer()
        }
        .padding()
    }

    private func passwordField(_ title: String, text: Binding<String>, isHidden: Binding<Bool>, errorMessage: Binding<String>?) -> some View {
        VStack(alignment: .leading) {
            Text(title).font(.headline)

            ZStack {
                if isHidden.wrappedValue {
                    SecureField("Enter \(title.lowercased())", text: text)
                } else {
                    TextField("Enter \(title.lowercased())", text: text)
                }
                HStack {
                    Spacer()
                    Button(action: {
                        isHidden.wrappedValue.toggle()
                    }) {
                        Image(systemName: isHidden.wrappedValue ? "eye.slash.fill" : "eye.fill")
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)

            // Display error message if exists
            if let errorMessage = errorMessage?.wrappedValue, !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }

    private func changePasswordButton() -> some View {
        Button(action: {
            Task {
                // Reset error messages and success message
                resetMessages()

                do {
                    // Validate old password
                    let isValidOldPassword = try await vm.validatePassword(email: FirebaseAuthManager.shared.getAuthenticatedUser().email ?? "", password: oldPassword)
                    guard isValidOldPassword else {
                        oldPasswordError = "Old password is incorrect!"
                        return
                    }

                    // Check if new passwords match
                    if newPassword != confirmPassword {
                        newPasswordError = "New passwords don't match!"
                        return
                    }

                    // Update password
                    try await vm.updatePassword(pass: newPassword)
                    updateSuccessMessage = "Password updated successfully!"

                } catch {
                    oldPasswordError = "Failed to update password: \(error.localizedDescription)"
                }
            }
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

    private func resetMessages() {
        oldPasswordError = ""
        newPasswordError = ""
        updateSuccessMessage = ""
    }
}

struct PasswordChangeView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordChangeView(vm: SettingsViewModel())
    }
}
