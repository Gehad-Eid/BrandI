//
//  TaskItemView.swift
//  project2
//
//  Created by sumaiya on 24/10/2567 BE.
//

import SwiftUI
import SwiftData

struct CalenderItemView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let item: Any
    
    @ObservedObject var vm: AgendaViewModel
    @ObservedObject var addPostVM: AddPostViewModel
    
    @State private var offset: CGFloat = 0
    @State private var showDelete: Bool = false
    @State private var showDeletePopup = false
    
    var body: some View {
        ZStack(alignment: .trailing) {
            // Background delete button
            if showDelete {
                DeleteButton
            }
            
            // Main content with swipe-to-delete functionality
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
                    .padding(.horizontal)
                
                Spacer()
                
                if let post = item as? Post {
                    HStack {
                        ForEach(post.platforms ?? [], id: \.self) { platform in
                            Image(platform.iconName(for: colorScheme))
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }
                    .padding(.trailing)
                }
            }
            .frame(width: 350, height: 60, alignment: .leading)
            .background(Color("BabyBlue"))
            .cornerRadius(12)
            .offset(x: offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.width < 0 {
                            offset = value.translation.width
                        }
                    }
                    .onEnded { value in
                        withAnimation {
                            if value.translation.width < -100 {
                                offset = -100
                                showDelete = true
                            } else {
                                offset = 0
                                showDelete = false
                            }
                        }
                    }
            )
            .frame(maxWidth: .infinity, maxHeight: 100, alignment: .leading)
    
            .padding(.horizontal)
            
            // Delete confirmation popup overlay
            if showDeletePopup {
                DeleteAlert
            }
        }
    }
    
    private var DeleteAlert: some View {
        DetetPostPopupView(
            onDelete: {
                withAnimation {
                    if let userID = UserDefaults.standard.string(forKey: "userID") {
                        if let post = item as? Post {
                            Task {
                                try await addPostVM.deletePost(userId: userID, postId: post.postId)
                            }
                            //context.delete(post)
                        } else if let event = item as? Event {
                            Task {
//                                try await addPostVM.deletePost(userId: userID, postId: post.postId)
                            }
                            
                            //context.delete(event)
                        }
                        
                        showDeletePopup = false
                    }
                    else {
                        print("userID not found")
                    }
                }
            },
            onCancel: {
                withAnimation {
                    showDeletePopup = false
                }
            }
        )
        .background(Color.clear)
        .zIndex(1)
        .padding(.trailing,60)
    }
    
    
    private var DeleteButton: some View {
        Button {
            showDeletePopup = true // Show delete confirmation popup
        } label: {
            Label("", systemImage: "trash")
                .font(.system(size: 30))
                .foregroundColor(.white)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: 180)
                .background(Color.red)
                .cornerRadius(12)
        }
        .padding(.trailing, 15)
        .transition(.move(edge: .trailing))
    }
}

#Preview {
    CalenderItemView(item: Post(postId: "1", title: "Ppo title", content: "content her babe", date: Date(), images: [], platforms: [.linkedin, .twitter], recommendation: "", isDraft: false) , vm: AgendaViewModel(), addPostVM: AddPostViewModel())
}
