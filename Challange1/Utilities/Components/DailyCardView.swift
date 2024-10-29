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
            } else {
                postsView
            }
        }
    }

    private var noPostsMessage: some View {
        //TODO: change withthe icon
        Text("No posts this day 😊")
            .font(.headline)
            .foregroundColor(.gray)
            .padding()
    }

    private var postsView: some View {
        ForEach(0..<min(posts.count, 3), id: \.self) { index in
            let post = posts[index]
            ReusableCardView(
                title: post.title,
                platforms: post.platforms ?? [],
                description: post.content,
                destination: AnyView(PostView(post: post, userId: ""))
            )
            .offset(y: CGFloat(index * 60)) // the Offset is based on index
        }
    }
}

#Preview {
    DailyCardView(posts: [])
}
