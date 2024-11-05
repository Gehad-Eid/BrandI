//
//  PageIndicator.swift
//  Challange1
//
//  Created by Gehad Eid on 04/11/2024.
//

import SwiftUICore

struct PageIndicator: View {
    @Binding var currentPage: Int
    var numberOfPages: Int

    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .fill(index == currentPage ? Color(.gray) : Color(.red))
                    .frame(width: 8, height: 8)
            }
        }
    }
}
