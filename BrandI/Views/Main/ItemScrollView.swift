//
//  ItemScrollView.swift
//  BrandI
//
//  Created by Gehad Eid on 17/11/2024.
//


import SwiftUI

struct ItemScrollView: View {
    @EnvironmentObject var vm: AgendaViewModel
    let items: [Any]
    
    let type: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading ,spacing: 16) {
                if !items.isEmpty {
                    ForEach(items.indices, id: \.self) { index in
                        ListItem(item: items[index])
                    }
                }
                else {
                    VStack {
                        Text("Nothing found")
                            .font(.headline)
                            .padding(.vertical)
                    }
                }
            }
            .padding(.top, 20)
        }
        .navigationTitle("Draft")
    }
}
