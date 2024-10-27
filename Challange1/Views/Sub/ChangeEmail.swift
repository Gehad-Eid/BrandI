//
//  SwiftUIView.swift
//  Challange1
//
//  Created by sumaiya on 24/10/2567 BE.
//

import SwiftUI

struct ChangeEmail: View {
    @State private var newEmail: String = ""
//    @ObservedObject var vm: SettingsViewModel
    @StateObject private var vm = MainViewModel()

    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack (alignment: .leading){
            //TODO: show old email
            
            Text("Email")
                .font(.headline)
//            TextField("Enter new email", text: $newEmail)
//                .padding()
//                .background(Color(.systemGray6))
//                .cornerRadius(10)
//                .padding(.bottom, 20)
//
            Text("\(vm.user?.email)")
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.bottom, 20)
            
            Text("\(vm.user?.dateCreated)")
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.bottom, 20)
            
            
            
//            Button(action: {
//                Task {
//                    do {
//                        try await vm.updateEmail(email: newEmail)
//                        alertMessage = "Email updated successfully!"
//                    } catch {
//                        alertMessage = "Failed to update email: \(error.localizedDescription)"
//                    }
//                    showAlert = true
//                }
//            }) {
//                Text("Change Email")
//                    .foregroundColor(.white)
//                    .fontWeight(.semibold)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.babyBlue)
//                    .cornerRadius(10)
//            }
//            .alert(alertMessage, isPresented: $showAlert) {
//                Button("OK", role: .cancel) { }
//            }
            Spacer()
        }
        .task {
            try? await vm.loadCurrentUser()
        }
        .padding()
    }
}


#Preview {
    ChangeEmail(/*vm: SettingsViewModel()*/)
}

