//
//  shortcut.swift
//  Challange1
//
//  Created by sumaiya on 15/11/2567 BE.
//

import SwiftUI
import _AppIntents_SwiftUI

struct shortcut: View {
    var body: some View {
        VStack {
                    ShortcutsLink()
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
                                .padding(.leading,50),
                            alignment: .center
                              )
            
        }
    }
}

#Preview {
    shortcut()
}
