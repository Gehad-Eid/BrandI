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
    
//    var array: [Any?] {
//        switch type {
//        case "posts":
//            return vm.thisMonthPosts ?? []
//        case "events":
//            return vm.thisMonthEvents ?? []
//        case "drafts":
//            return vm.thisMonthDraftPosts ?? []
//        default:
//            return []
//        }
//    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading ,spacing: 16) {
                ForEach(items.indices, id: \.self) { index in
                    ListItem(item: items[index])
                }
            }
            
            .padding(.top, 20)
        }
    }
}
