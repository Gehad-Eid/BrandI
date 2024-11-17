//
//  BrandIdintityView.swift
//  Challange1
//
//  Created by sumaiya on 24/10/2567 BE.
//

import SwiftUI

struct BrandIdentityView: View {
    @EnvironmentObject var mainViewModel: MainViewModel
    @StateObject var vm = SettingsViewModel()
    @StateObject var brandVM = BrandIdintityViewModel()
    @State private var showImagePicker: Bool = false
    let onDone: (() -> Void)?

    // Expanded categories list
    let categories = [
        "Technology", "Health", "Education", "Environment", "Business",
        "Science", "Arts", "Sports", "Entertainment", "Finance",
        "Food", "Travel", "Lifestyle", "Fashion", "Music",
        "Politics", "Culture", "Gaming", "Real Estate", "Automotive"
    ]

    var body: some View {
        VStack(alignment: .center) {
            ScrollView(showsIndicators: false) {
                // Split complex UI components into smaller views
                BrandInputSection(brandVM: brandVM, categories: categories, showImagePicker: $showImagePicker)
                BrandImageSection(brandVM: brandVM, showImagePicker: $showImagePicker)
                
                if let onDone = onDone {
                    UploadButtonSection(brandVM: brandVM, updateBrand: vm.updateBrand, onDone: onDone)
                } else {
                    UploadButtonSection(brandVM: brandVM, updateBrand: vm.updateBrand, onDone: nil)
                }
                
                Spacer()
            }
            .onAppear(){
                loadUserBrand()
            }
        }
        .task {
            try? await mainViewModel.loadCurrentUser()
        }
        .padding()
    }
    
    private func loadUserBrand() {
        // Check if the user is loaded
        if let user = mainViewModel.user {
            // there's only one brand for user
            if let userBrand = user.brand?.first {
                brandVM.identityText = userBrand.purpose
                brandVM.audianceText = userBrand.audience
                brandVM.selectedCategory = userBrand.category
                brandVM.colorText = userBrand.colors
                brandVM.nameText = userBrand.name
            }
        }
    }
}

#Preview {
    BrandIdentityView(onDone: nil)
}
