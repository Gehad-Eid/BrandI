//
//  DailyCardView.swift
//  Challange1
//
//  Created by Gehad Eid on 26/10/2024.
//


import SwiftUI

struct DailyCardView: View {
    let posts: [Post]
    
    var body: some View {
        ZStack {
            if posts.isEmpty {
                    noPostsMessage
                    .padding(.top, -150)
            } else {
                postsView
                    .padding(.top, -150)
            }
        }
        
    }
    
    private var noPostsMessage: some View {
        VStack(alignment: .center, spacing: 5) {
            Image("emptyPosts")
                .resizable()
                .frame(width: 111, height: 74)
                .padding()
            
            Text("No Posts Scheduled Yet")
                .foregroundColor(Color("GrayText"))
                .bold()
                .font(.system(size: 13))
            
            Text("Tap the \"+\" button to get started")
                .foregroundColor(Color("GrayText"))
                .font(.system(size: 15))
        }
    }
    
    private var postsView: some View {
        ForEach(0..<min(posts.count, 3), id: \.self) { index in
            let post = posts[index]
            ReusableCardView(
                title: post.title,
                platforms: post.platforms ?? [],
                selectedImages: post.images ?? [],
                description: post.content,
                destination: AnyView(EditView(post: post))
            )
            .offset(y: CGFloat(index * 60)) // 200 -> // TODO: make expandable
        }
    }
}

#Preview {
    DailyCardView(posts: [])
}
