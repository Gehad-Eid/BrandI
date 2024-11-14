//
//  AddNoteIntent.swift
//  Challange1
//
//  Created by sumaiya on 25/10/2567 BE.
//

import Foundation
import AppIntents
import SwiftUI



struct PostAddedView: View {
    let post: Post
    
    var body: some View {
      
            VStack(spacing: 0) {
                // Title & Platforms
                HStack {
                    Text(post.title)
                        .foregroundStyle(Color.white)
                        .fontWeight(.semibold)
                        .padding()
                    Spacer()
//                    Image("SiriIcon")
//                        .resizable()
//                        .frame(width:40 , height: 40)
//                        .padding(.trailing, 12)
//                        .shadow(color: Color.white, radius: 0.3, x: 1, y: 1)
                   
                }
                .background(Color("BabyBlue"))
                .frame(width: 330, height: 50)
                .background(Color.black)
                              .shadow(radius: 10, x: 10, y: 10)
                .clipShape(TopCornersRoundedRectangle(radius: 18))
              
                
                // Details
                VStack(alignment: .leading) {
                    HStack {
                        Text(post.content)
                            .foregroundColor(Color.black)
                            .padding(.top, 16)
                            .padding(.leading, 16)
                        Spacer()
                    }
                    Spacer()
                }
                .frame(width: 330, height: 180)
                .background(Color.white)
                .clipShape(BottomCornersRoundedRectangle(radius: 18))
                
            }.padding(.vertical, 16)
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 2, y: 2)
        }
  
    
}
#Preview {
    PostAddedView(post:Post(postId:"",title: "Hello World", content: "Hello World", date:Date(), images:nil, isDraft: true ))
}
//here with custom view

struct AddPostIntent: AppIntent {
    static let title: LocalizedStringResource = "Add a post with Siri"
    
    @Parameter(title: "Post Title")
    var postTitle: String
    
    @Parameter(title: "Post Content")
    var postContent: String
    
    

    func perform() async throws -> some IntentResult & ProvidesDialog & ShowsSnippetView {
        // Create a MainViewModel instance
        let viewModel = await SiriViewModel()
          
        // Create a new note with the provided title, content, and image data
        let newNote = Post(postId:"",title: postTitle, content: postContent, date:Date(), images:nil, isDraft: true )

        // Save the note using the viewModel
        try await viewModel.addPostToDB(note: newNote)

        // Provide feedback to the user through Siri
        let dialog = IntentDialog("Got it! Your post has been saved as a draft.")

        // Return a custom SwiftUI view showing the note
        let snippetView = PostAddedView(post: newNote)

        return .result(dialog: dialog, view: snippetView)
    }
}

