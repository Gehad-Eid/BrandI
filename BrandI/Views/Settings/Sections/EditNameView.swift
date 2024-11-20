//
//  EditNameView.swift
//  Challange1
//
//  Created by sumaiya on 03/11/2567 BE.
//

import SwiftUI


struct EditNameView: View {
    @EnvironmentObject var vm: MainViewModel
    
    @ObservedObject var vmSettings: SettingsViewModel
    
    @State private var fullName: String = ""
    @State private var account: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                if let user = vm.user {
                    if !(user.name?.isEmpty ?? true || user.name == nil) {
                        VStack(alignment: .leading) {
                            Text("Name").font(.title3)
                            Text("\(user.name ?? "Not Available")")
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                                .foregroundColor(Color(.gray))
                                .padding(.bottom, 20)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Email").font(.title3)
                         
                        Text("\(user.email ?? "Not Available")")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .foregroundColor(Color(.gray))
                            .padding(.bottom, 20)
                    }
                    
                    if vmSettings.authProviders.contains(where: { $0 == .email }) {
                        VStack{
                            settingsRow(iconName: "key.fill",
                                        title: "Change Password",
                                        destination: PasswordChangeView(vm: vmSettings).navigationBarHidden(true),
                                        isSystemImage: true
                            )
                        }.background(Color(.systemGray6))
                            .cornerRadius(12)
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
                else {
                    
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Account")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
            }
        }
        .task {
            try? await vm.loadCurrentUser()
        }
    }
    
    // Reusable Row for Settings Items
    @ViewBuilder
    private func settingsRow<Destination: View>(iconName: String, title: String, destination: Destination,isSystemImage: Bool = true
    ) -> some View {
        NavigationLink(destination: destination) {
            HStack {
                if isSystemImage {
                    Image(systemName: iconName)
                        .foregroundColor(.babyBlue)
                } else {
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.babyBlue)
                }
                Text(title)
                    .font(.system(size: 18, weight: .medium))
                    .padding(.leading, 10)
                Spacer()
            }
            .padding()
            //        .background(RoundedRectangle(cornerRadius: 18)
            //            .fill(Color("BoxColor")))
        }
    }
}

//#Preview {
//    EditNameView()
//}


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
