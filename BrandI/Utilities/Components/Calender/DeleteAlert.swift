//
//  DeleteAlert.swift
//  Challange1
//
//  Created by Gehad Eid on 05/11/2024.
//


import SwiftUI

struct DeleteAlert: View {
    @EnvironmentObject var addPostVM: AddPostViewModel
    
    @Binding var showDeletePopup: Bool
    let item: Any

    var body: some View {
        DetetPostPopupView(
            onDelete: {
                withAnimation {
                    if let userID = UserDefaults.standard.string(forKey: "userID") {
                        print("here")
                        print(item)
                        if let post = item as? Post {
                            print("ppost")
                            Task {
                                try await addPostVM.deletePost(userId: userID, postId: post.postId)
                            }
                        } else if let event = item as? Event {
                            print("eevent")
                            Task {
                                try await addPostVM.deleteEvent(userId: userID, eventId: event.eventId)
                            }
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
    }
}
