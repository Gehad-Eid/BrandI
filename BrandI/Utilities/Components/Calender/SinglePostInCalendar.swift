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
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(Color("Text"))
            
            Text(message)
//                .font(.subheadline)
                .font(.body)
//                .foregroundColor(.gray)
                .foregroundColor(Color("GrayText"))
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            HStack {
                Button(action: onCancel) {
                    Text("Cancel")
                        .foregroundColor(Color("Text"))
                        .padding(.horizontal,8)
                        .padding(.vertical,2)
                        .frame(maxWidth: .infinity)
                        .frame(height: 51)
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("Text"), lineWidth: 1)
                        )
                }
                
                Button(action: onDelete) {
                    Text("Delete")
                        .foregroundColor(Color.white)
                        .padding(.horizontal,8)
                        .padding(.vertical,2)
                        .frame(maxWidth: .infinity)
                        .frame(height: 51)
                        .background(Color.red)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .frame(width: 330/*, height: 220*/)
        .background(Color("BoxColor"))
        .cornerRadius(18)
        .shadow(radius: 10)
    }
}

struct DetetPostPopupView: View {
    var onDelete: () -> Void
    var onCancel: () -> Void

    var body: some View {
        GenericPopupView(
            title: "Delete this post?",
            message: "Are you sure you want to delete This? This action cannot be undone", //\nThis action cannot be undone.
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
