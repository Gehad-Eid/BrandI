//
//  SinglePostInCalendar.swift
//  Challange1
//
//  Created by sumaiya on 24/10/2567 BE.
//

import SwiftUI

struct SinglePostInCalendar: View {
    @State private var posts: [[String: Any]] = [
        ["title": "Post Title 1", "imageName": "document.fill", "platformList": ["document.fill", "document.fill", "document.fill"]],
        ["title": "Post Title 2", "imageName": "document.fill", "platformList": ["document.fill", "document.fill", "document.fill"]],
        ["title": "Post Title 3", "imageName": "document.fill", "platformList": ["document.fill", "document.fill", "document.fill"]]
    ]

    var body: some View {
        List {
            ForEach(posts.indices, id: \.self) { index in
                if let post = posts[index] as? [String: Any] {
                    SinglePostRow(
                        postTitle: post["title"] as? String ?? "",
                        imageName: post["imageName"] as? String ?? "document",
                        platformList: post["platformList"] as? [String] ?? [],
                        onTap: {
                            // Handle tap
                        }
                    )
                    .swipeActions {
                        Button(role: .destructive) {
                            deletePost(at: index)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    .padding(.vertical, 10) // Add padding for spacing
                }
            }
        }
        .listStyle(PlainListStyle()) // Remove default styling
        .background(Color.clear) // Background color for List
    }

    private func deletePost(at index: Int) {
        posts.remove(at: index)
    }
}
#Preview {
    SinglePostInCalendar()
}


struct SinglePostRow: View {
    var postTitle: String
    var imageName: String
    var platformList: [String]
    var onTap: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .center) {
                Image(systemName: imageName)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 30))
            }
            .padding(.leading)
            
            Rectangle()
                .frame(width: 1)
                .foregroundColor(.gray)
                .padding(.vertical)
            
            Text(postTitle)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .padding(.horizontal)
            
            Spacer()
            
            HStack {
                            Spacer()
                            
                            // Loop through the platform array
                            ForEach(platformList, id: \.self) { platformList in
                                Image(systemName: imageName)
                                    .foregroundStyle(Color.white)
                                    .font(.system(size: 20))
                            }
                        }
                        .padding(.trailing)
                        .padding(.top, -28)
        }
        .frame(width: 350, height: 100, alignment: .leading)
        .background(Color("BabyBlue"))
        .cornerRadius(18)
        .onTapGesture {
            onTap()
        }
        .shadow(color: Color.black.opacity(0.4), radius: 3, x: 2, y: 3)
    }
}


//Pop Up Views For deleting the Post and the Days Post
struct GenericPopupView: View {
    var title: String
    var message: String
    var onDelete: () -> Void
    var onCancel: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            VStack {
                Button(action: onDelete) {
                    Text("Delete")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 51)
                        .background(Color.babyBlue)
                        .cornerRadius(8)
                }

                Button(action: onCancel) {
                    Text("Cancel")
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: 300, height: 51)
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
            }
        }
        .padding()
        .frame(width: 380, height: 288)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
}

struct DetetPostPopupView: View {
    var onDelete: () -> Void
    var onCancel: () -> Void

    var body: some View {
        GenericPopupView(
            title: "Delete this post?",
            message: "Are you sure you want to delete “Event/Post Title”? This cannot be undone.",
            onDelete: onDelete,
            onCancel: onCancel
        )
    }
}

struct ClearTheDayPopupView: View {
    var onDelete: () -> Void
    var onCancel: () -> Void

    var body: some View {
        GenericPopupView(
            title: "Clear the day",
            message: "Are you sure you want to delete everything for today? This can't be undone.",
            onDelete: onDelete,
            onCancel: onCancel
        )
    }
}

#Preview {
    DetetPostPopupView(onDelete: {}, onCancel: {})
}

#Preview {
    ClearTheDayPopupView(onDelete: {}, onCancel: {})
}
