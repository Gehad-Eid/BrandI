//
//  BrandIdintityView.swift
//  Challange1
//
//  Created by sumaiya on 24/10/2567 BE.
//

import SwiftUI

struct BrandIdentityView: View {
    @State private var identityText: String = ""
    @State private var selectedImage: Image? = nil
    @State private var showImagePicker: Bool = false

    var body: some View {
        VStack(alignment: .center) {
            
            // Identity Text Field
            VStack(alignment: .leading) {
                Text("Describe your brand identity")
                               .font(.title3)
                               .bold()
                           TextField("Innovative, Friendly, Professional", text: $identityText)
                               .padding()
                               .background(Color.background)
                               .cornerRadius(10)
                
                Text("Brand identity image")
                    .font(.title3)
                    .bold()
                
            }
           


        
           
            VStack() {
                if let selectedImage = selectedImage {
                    selectedImage
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .cornerRadius(20)
                } else {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.background)
                        .frame(width: 350,height: 300)
                    
                        .overlay(
                            VStack{
                                Image("Vector")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .padding(.bottom, 30)
                                Text("Let us know how your brand looks")
                                    .foregroundColor(.gray)
                                Button(action: {
                                    showImagePicker.toggle()
                                }) {
                                    HStack {
                                        Image(systemName: "photo")
                                            .foregroundColor(.white)
                                        Text("Upload Image")
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)
                                    }
                                    .padding()
                                    .frame(width:200, height:50)
                                    .background(Color("BabyBlue"))
                                    .cornerRadius(10)
                                }
                                .sheet(isPresented: $showImagePicker) {
                                   
                                }
                            }
                        )
                }
            }
            .onTapGesture {
                showImagePicker.toggle()
            }
            HStack{
                Text("Format: JPEG, PNG | Size: 1200x800 pixels | Max size: 5MB")
                    .foregroundColor(.gray)
                    .font(.caption)
                Spacer()
            }.padding(.top,10)
          

            // Upload Button
            

            Spacer()
        }
        .padding()
    }
}


#Preview {
    BrandIdentityView()
}
