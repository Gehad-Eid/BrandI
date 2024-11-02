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
        VStack(alignment: .leading, spacing: 10) {
            Text("Post Added")
                .font(.headline)
            Text("Title: \(post.title)")
                .font(.subheadline)
            Text("Content: \(post.content)")
                .font(.body)
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
//here with deafult siri view
//struct AddNoteIntent: AppIntent {
//    static let title: LocalizedStringResource = "Add a note with Siri"
//
//    @Parameter(title: "Note Title")
//    var noteTitle: String
//
//    @Parameter(title: "Note Content")
//    var noteContent: String
//
//    // This method will be triggered by Siri to add the note
//    func perform() async throws -> some IntentResult & ProvidesDialog {
//        // Create a MainViewModel instance
//        let viewModel = MainViewModel()
//
//        // Create a new note with the provided title and content
//        let newNote = Note(title: noteTitle, content: noteContent)
//
//        // Save the note using the viewModel
//        viewModel.writeValuesToUserDefaults(note: newNote)
//
//        // Provide feedback to the user through Siri
//        return .result(dialog: "Your post has been saved.")
//    }
//}

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
        let dialog = IntentDialog("Your post has been uploaded successfully.")

        // Return a custom SwiftUI view showing the note
        let snippetView = PostAddedView(post: newNote)

        return .result(dialog: dialog, view: snippetView)
    }
}

