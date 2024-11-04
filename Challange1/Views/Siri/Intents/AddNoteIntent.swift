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
                        .foregroundStyle(Color("Text"))
                        .fontWeight(.semibold)
                        .padding()
                    Spacer()
                   
                }
                .frame(width: 330, height: 50)
                              .background(Color.white)
                .background(Color("BoxColor"))
                .clipShape(TopCornersRoundedRectangle(radius: 18))
              
                
                // Details
                VStack(alignment: .leading) {
                    HStack {
                        Text(post.content)
                            .foregroundColor(Color.white)
                            .padding(.top, 16)
                            .padding(.leading, 16)
                        Spacer()
                    }
                    Spacer()
                }
                .frame(width: 330, height: 180)
                .background(Color("BabyBlue"))
                .clipShape(BottomCornersRoundedRectangle(radius: 18))
                
            }.padding(.vertical, 16)
        }
    
            
    
    
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
        let dialog = IntentDialog("Your post has been saved successfully.")

        // Return a custom SwiftUI view showing the note
        let snippetView = PostAddedView(post: newNote)

        return .result(dialog: dialog, view: snippetView)
    }
}

