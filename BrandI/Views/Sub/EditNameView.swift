//
//  EditNameView.swift
//  Challange1
//
//  Created by sumaiya on 03/11/2567 BE.
//

import SwiftUI


struct EditNameView: View {
    @EnvironmentObject var vm: MainViewModel

    @State private var fullName: String = ""
    @State private var account: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                if let user = vm.user {
                    if !(vm.user?.name?.isEmpty ?? true || vm.user?.name == nil) {
                        VStack {
                            Text("Name").font(.headline)
                            Text("\(vm.user?.name ?? "Not Available")")
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(.systemGray6))
                                .cornerRadius(9)
                                .padding(.horizontal)
                                .padding(.bottom, 20)
                        }
                    }
                    
                    VStack {
                        Text("Name").font(.headline)
                        Text("\(vm.user?.email ?? "Not Available")")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.systemGray6))
                            .cornerRadius(9)
                            .foregroundColor(Color(.gray))
                            .padding(.horizontal)
                            .padding(.bottom, 20)
                    }
                    
//                    Text("\(vm.user?.name ?? "Not Available")")
//                        .padding()
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .background(Color(.systemGray6))
//                        .cornerRadius(9)
//                        .padding(.horizontal)
//                        .padding(.bottom, 20)
//
//                     Full Name TextField
//                                    AppTextField(
//                                        text: $fullName,
//                                        placeholder: "Enter Full Name"
//                                    ) {
//                    
//                                        print("Navigating from Full Name")
//                                    }
//
//                    
//                    AppTextField(
//                        text: $account,
//                        placeholder: "Enter Account"
//                    ) {
//                        // Action on tap or enter
//                        print("Navigating from Account")
//                    }
//                    
//                    
//                    AppTextField(
//                        text: $password,
//                        placeholder: "Enter Password",
//                        isSecure: true
//                    ) {
//                        
//                        print("Navigating from Password")
//                    }
                    
                    Spacer()
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Profile")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
            }
        }
        .task {
            try? await vm.loadCurrentUser()
        }
    }
}

#Preview {
    EditNameView()
}


struct AppTextField: View {
    @Binding var text: String
    var placeholder: String
    var isSecure: Bool = false
    var onCommit: (() -> Void)?

    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text, onCommit: {
                    onCommit?()
                })
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            } else {
                TextField(placeholder, text: $text, onCommit: {
                    onCommit?()
                })
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }
        }
        .padding(.bottom, 20)
        .onTapGesture {
            onCommit?()
        }
    }
}
