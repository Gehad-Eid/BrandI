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
    @State private var showDeleteAlert = false
    
    @State private var showPasswordPrompt = false
//    @State private var passwordInput: String = ""
    
    var body: some View {
        ZStack{
            NavigationView {
                List {
                    
                    Section {
                        // TODO: pretty suer that should change to account at least !!
                        settingsRow(iconName: "envelope", title: "Profile", destination: ChangeEmail(/*vm: vm*/),
                        isSystemImage: true)
                        
                        // TODO: pretty suer that should change !!
                        settingsRow(iconName: "key.fill", title: "Change Password", destination: PasswordChangeView(vm: vm),
                                    isSystemImage: true
                        )
                        
                        // API Integration
                        settingsRow(iconName: "link", title: "Linked Accounts", destination: IntegrationView(),
                                    isSystemImage: true)
                        
                        // Identity - AI
                        settingsRow(iconName: "light", title: "My Brand Identity",
                                    destination: BrandIdentityView(),
                                    
                                    isSystemImage: false
                        )
                        
                    }
                    
                    // Sign Out
                    Section {
                        Button()
                        {
                            showSignOutAlert = true
                        } label: {
                            HStack {
                                Image(systemName: "arrowshape.turn.up.left")
                                    .foregroundColor(.babyBlue)
                                
                                Text("Sign Out")
                                    .font(.system(size: 18, weight: .medium))
                                    .padding(.leading, 10)
                                    .foregroundColor(.black) // ADDED
                                Spacer()
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 18)
                                .fill(Color.white))
                        }
                        .alert(isPresented: $showSignOutAlert) {
                            Alert(
                                title: Text("Are you sure?"),
                                message: Text("Do you really want to sign out?"),
                                primaryButton: .destructive(Text("Sign Out")) {
                                    Task {
                                        do {
                                            try vm.signOut()
                                            isAuthenticated = false
                                        } catch {
                                            print("Error signing out: \(error)")
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
                            .background(RoundedRectangle(cornerRadius: 18)
                                .fill(Color.white))
                        }
                        HStack(){
                            ShortcutsLink()
                        }.padding(.leading,60)
                            .padding(.vertical,8)
                       
                        
                        //                    .alert(isPresented: $showDeleteAlert) {
                        //                        Alert(
                        //                            title: Text("Delete Account"),
                        //                            message: Text("Enter your password to confirm deletion."),
                        //                            primaryButton: .default(Text("Confirm")) {
                        //                                showPasswordPrompt = true  // Show password input
                        //                            },
                        //                            secondaryButton: .cancel()
                        //                        )
                        //                    }
                        //                    .sheet(isPresented: $showPasswordPrompt) {
                        //                        VStack {
                        //                            Text("Confirm Deletion")
                        //                                .font(.headline)
                        //                            SecureField("Password", text: $passwordInput)
                        //                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        //                                .padding()
                        //
                        //                            Button("Delete Account") {
                        //                                Task {
                        //                                    do {
                        //                                        // Validate the password before deleting
                        ////                                        if await vm.validatePassword(passwordInput) {
                        ////                                            try await vm.deleteAccount()
                        ////                                            isAuthenticated = false
                        ////                                        } else {
                        ////                                            // Handle incorrect password
                        ////                                            print("Incorrect password.")
                        ////                                            // Optionally, show an alert here for incorrect password
                        ////                                        }
                        //                                    } catch {
                        //                                        print("Failed to delete account: \(error.localizedDescription)")
                        //                                    }
                        //                                }
                        //                            }
                        //                            .padding()
                        //                        }
                        //                        .padding()
                        //                    }
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
        .background(RoundedRectangle(cornerRadius: 18)
            .fill(Color.white))
    }
}


#Preview {
    SettingsView(isAuthenticated: .constant(false))
}
