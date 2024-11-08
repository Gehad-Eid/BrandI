//
//  PrivacyPolicyView.swift
//  BrandI
//
//  Created by Gehad Eid on 06/11/2024.
//


import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Privacy Policy for Brandi")
                    .font(.title)
                    .bold()
                Text("Last updated: November 04, 2024")
                    .italic()

                Section(header: Text("Privacy Policy").font(.headline)) {
                    Text("""
                    This Privacy Policy describes Our policies and procedures on the collection, use, and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.
                    
                    We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy.
                    """)
                }

                Section(header: Text("Interpretation and Definitions").font(.headline)) {
                    Text("""
                    The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.
                    """)
                }

                // Add remaining sections here
                Section(header: Text("Collecting and Using Your Personal Data").font(.headline)) {
                    Text("""
                    Types of Data Collected
                    - Personal Data: While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to: Email address, Usage Data.
                    """)
                }

                Section(header: Text("Use of Your Personal Data").font(.headline)) {
                    Text("""
                    The Company may use Personal Data for the following purposes:
                    - To provide and maintain our Service, including monitoring the usage of our Service.
                    - To manage Your Account: Registration as a user of the Service.
                    - To contact You: Updates, special offers, and notifications related to the Service.
                    """)
                }
                
                // Continue for each policy section
                Section(header: Text("Contact Us").font(.headline)) {
                    Text("""
                    If you have any questions about this Privacy Policy, You can contact us:
                    
                    By email: myasemmuner@gmail.com
                    
                    By phone: 966551742409
                    """)
                }
            }
            .padding()
        }
        .navigationTitle("Privacy Policy")
    }
}
