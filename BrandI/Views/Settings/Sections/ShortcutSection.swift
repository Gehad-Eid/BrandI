//
//  SiriSection.swift
//  Challange1
//
//  Created by sumaiya on 18/11/2567 BE.
//

import SwiftUI
import _AppIntents_SwiftUI

struct Shortcut: View {
    var body: some View {
        VStack {
            ShortcutsLink()
                .shortcutsLinkStyle(.dark)
                
                .overlay(
                    VStack {
                        Text("BrandI Shortcut")
                            .fontWeight(.semibold)
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(8)
                    }
                    .padding(.leading, 50)
                    .allowsHitTesting(false),
                    alignment: .center
                )
        }
    }
}

#Preview {
    Shortcut()
}

