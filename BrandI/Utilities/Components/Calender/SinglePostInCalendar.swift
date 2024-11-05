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
                .foregroundColor(Color("Text"))
            
            Text(message)
                .font(.subheadline)
//                .foregroundColor(.gray)
                .foregroundColor(Color("GrayText"))
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            VStack {
                Button(action: onDelete) {
                    Text("Delete")
                        .foregroundColor(Color("Text"))
                        .padding()
                        .frame(width: 230, height: 51)
                        .background(Color.babyBlue)
                        .cornerRadius(8)
                }

                Button(action: onCancel) {
                    Text("Cancel")
                        .foregroundColor(Color("Text"))
                        .padding()
                        .frame(width: 230, height: 51)
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("Text"), lineWidth: 1)
                        )
                }
            }
        }
        .padding()
        .frame(width: 280, height: 258)
        .background(Color("BoxColor"))
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
            message: "Are you sure you want to delete this?", //\nThis action cannot be undone.
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
