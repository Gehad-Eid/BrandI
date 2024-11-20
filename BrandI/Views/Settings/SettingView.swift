//
//  SettingView.swift
//  Challange1
//
//  Created by sumaiya on 21/10/2567 BE.
//

import SwiftUI
import _AppIntents_SwiftUI

struct SettingsView: View {
    
    @StateObject var vm = SettingsViewModel()
    @Binding var isAuthenticated: Bool
    
    @State private var showSignOutAlert = false
    @State private var showSignInSheet = false
    @State private var showDeleteAlert = false
    
    @State private var showPasswordPrompt = false
    
    @State private var counter = 0
    
    var body: some View {
        ZStack{
            NavigationView {
                List {
                    if isAuthenticated /*let userID = UserDefaults.standard.string(forKey: "userID")*/ {
                        Section {
                            // TODO: pretty suer that should change to account at least !!
                            settingsRow(iconName: "person.crop.circle",
                                        title: "Profile",
                                        destination: EditNameView(vmSettings: vm),
                                        isSystemImage: true
                            )
                            
//                            if vm.authProviders.contains(where: { $0 == .email }) {
//                                // TODO: pretty suer that should change !!
//                                settingsRow(iconName: "key.fill",
//                                            title: "Change Password",
//                                            destination: PasswordChangeView(vm: vm),
//                                            isSystemImage: true
//                                )
//                            }
                            
                            // API Integration
                            //settingsRow(iconName: "link",
                            //            title: "Linked Accounts",
                            //            destination: IntegrationView(),
                            //            isSystemImage: true
                            //)
                            
                            // Identity - AI
                            settingsRow(iconName: "light",
                                        title: "My Brand Identity",
                                        destination: BrandIdentityView(onDone: nil),
                                        isSystemImage: false
                            )
                            //                        }
                            //
                            //                        Section {
                            
                            // Sign Out
                            Button()
                            {
                                showSignOutAlert = true
                            } label: {
                                HStack {
                                    Image(systemName: "iphone.and.arrow.forward.inward")
                                        .foregroundColor(.babyBlue)
                                    
                                    Text("Sign Out")
                                        .font(.system(size: 18, weight: .medium))
                                        .padding(.leading, 10)
                                        .foregroundColor(Color("Text")) // ADDED
                                    Spacer()
                                }
                                .padding()
                                // .background(RoundedRectangle(cornerRadius: 18)
                                // .fill(Color.white))
                            }
                            .alert(isPresented: $showSignOutAlert) {
                                Alert(
                                    title: Text("Are you sure?"),
                                    message: Text("Do you really want to sign out?"),
                                    primaryButton: .destructive(Text("Sign Out")) {
                                        Task {
                                            try vm.signOut(){
                                                isAuthenticated = false
                                            }
                                        }
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                            
                            // Delete Account
                            Button(role: .destructive)
                            {
                                showDeleteAlert = true
                                
                            } label: {
                                HStack {
                                    Image(systemName: "trash.fill")
                                    Text("Delete Account")
                                        .font(.system(size: 18, weight: .medium))
                                        .padding(.leading, 10)
                                    Spacer()
                                }
                                .padding()
                                // .background(RoundedRectangle(cornerRadius: 18)
                                // .fill(Color.white))
                            }
                            
                            VStack {
                                Shortcut()
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    else {
                        VStack {
                            Text("Sign in to enjoy the full functionality of the app and access your account and settings.")
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding()
                            
                            Button()
                            {
                                showSignInSheet = true
                            } label: {
                                HStack {
                                    Image(systemName: "arrowshape.turn.up.right")
                                        .foregroundColor(.babyBlue)
                                    
                                    Text("Sign In")
                                        .font(.system(size: 18, weight: .medium))
                                        .padding(.leading, 10)
                                        .foregroundColor(Color("Text")) // ADDED
                                    Spacer()
                                }
                                .padding()
                            }
                            .sheet(isPresented: $showSignInSheet) {
                                AuthContainerView(isAuthenticated: $isAuthenticated, showSignInSheet: $showSignInSheet)
                            }
                            //                            .onChange(of: isAuthenticated) { authenticated in
                            //                                if authenticated {
                            //                                    showSignInSheet = false
                            //                                }
                            //                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.background)
                .navigationTitle("Settings")
            }
            
            // Custom Alert for Password Input
            if showDeleteAlert {
                confirmPassPopUp(showDeleteAlert: $showDeleteAlert, isAuthenticated: $isAuthenticated, vm: vm)
            }
        }
        .onAppear(){
            vm.loadAuthProviders()
        }
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


#Preview {
    SettingsView(isAuthenticated: .constant(false))
}
