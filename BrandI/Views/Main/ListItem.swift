//
//  ListItem.swift
//  BrandI
//
//  Created by Gehad Eid on 17/11/2024.
//

import SwiftUI

struct ListItem: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var vm: AgendaViewModel
    
    @State private var showingAddPostView = false
    
    var item: Any
    
    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .center) {
                Image(systemName: vm.getImageName(for: item))
                    .foregroundStyle(Color.white)
                    .font(.system(size: 30))
            }
            .padding(.leading)
            
            Rectangle()
                .frame(width: 1)
                .foregroundColor(.gray)
                .padding(.vertical)
            
            Text(vm.getTitle(for: item))
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            Spacer()
            
            if let post = item as? Post {
                HStack {
                    ForEach(post.platforms ?? [], id: \.self) { platform in
                        Image(platform.iconName(for: colorScheme))
                            .resizable()
                            .frame(width: 18, height: 18)
                    }
                }
                .padding(.trailing)
                .padding(.top, -15)
            }
        }
        .onTapGesture {
            showingAddPostView = true
        }
        .frame(width: 350, height: 60, alignment: .leading)
        .background(Color("BabyBlue"))
        .cornerRadius(12)
        .fullScreenCover(isPresented: $showingAddPostView) {
            EditView(post: item as? Post , event: item as? Event )
        }
    }
}
