//
//  SinglePostInCalendar.swift
//  Challange1
//
//  Created by sumaiya on 24/10/2567 BE.
//

import SwiftUI



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
                        .frame(width: 230, height: 51)
                        .background(Color.babyBlue)
                        .cornerRadius(8)
                }

                Button(action: onCancel) {
                    Text("Cancel")
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: 230, height: 51)
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
            }
        }
        .padding()
        .frame(width: 280, height: 258)
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
