//
//  UpcomingCard.swift
//  Challange1
//
//  Created by Gehad Eid on 29/10/2024.
//

import SwiftUI

struct UpcomingCard: View {
    let item: Any
    @ObservedObject var vm: AgendaViewModel  // For extracting details

    var body: some View {
        let post = item as? Post
        
        NavigationLink(destination: CreatePostView(post: post)) {
            HStack {
                VStack(alignment: .center) {
                    Image(systemName: vm.getImageName(for: item))
                        .foregroundStyle(Color("BabyBlue"))
                        .font(.system(size: 30))
                    
                    Text(vm.getRemainDate(for: item))
                        .foregroundStyle(Color("BabyBlue"))
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text(vm.getTitle(for: item))
                        .foregroundStyle(.black)
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                    
                    Text(vm.getDate(for: item))
                        .font(.caption)
                        .foregroundStyle(Color("GrayText"))
                }
            }
            .frame(width: 350, height: 80, alignment: .leading)
            .background(Color("BoxColor"))
            .cornerRadius(18)
        }
    }
}