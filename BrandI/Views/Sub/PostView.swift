//
//  Post.swift
//  Challange1
//
//  Created by Gehad Eid on 19/10/2024.
//

import SwiftUI

struct PostView: View {
    
    @StateObject private var vm = PostViewModel()
    
    let post: Post
    let userId: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(post.title)
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 8)
            
            Text(post.postId)
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 8)
            
            Text(post.content)
                .font(.body)
                .padding(.bottom, 16)
            
            Text("Posted on: \(post.date, style: .date)")
                .font(.caption)
                .foregroundColor(.gray)
            
            // is draft
            Button {
                vm.updatePost(userId: userId, post: post)
            }
            label: {
                Text("is draft: \((post.isDraft ?? false).description.capitalized)")
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Post Details")
    }
}
