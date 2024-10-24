//
//  SwiftUIView.swift
//  Challange1
//
//  Created by sumaiya on 24/10/2567 BE.
//

import SwiftUI

struct ChangeEmail: View {
    @State private var newEmail: String = ""

    var body: some View {
        VStack (alignment: .leading){
            Text("Email")
                .font(.headline)
            TextField("Enter new email", text: $newEmail)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.bottom, 20)
            
          
            Button(action: {
              
                print("New Email: \(newEmail)")
            }) {
                Text("Change Email")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.babyBlue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ChangeEmail()
}

