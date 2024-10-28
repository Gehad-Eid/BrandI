//
//  AddNoteIntent.swift
//  Challange1
//
//  Created by sumaiya on 25/10/2567 BE.
//

import Foundation
import AppIntents
import SwiftUI



struct NoteAddedView: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Note Added")
                .font(.headline)
            Text("Title: \(post.title)")
                .font(.subheadline)
            Text("Content: \(post.content)")
                .font(.body)
//            if let imageData = post.images, let uiImage = UIImage(data: imageData) {
//                         Image(uiImage: uiImage)
//                             .resizable()
//                             .aspectRatio(contentMode: .fit)
//                             .frame(height: 200)
//                             .cornerRadius(10)
//                     } else {
//                         Text("No Image Available")
//                             .font(.body)
//                             .foregroundColor(.gray)
//                     }
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

struct AddNoteIntent: AppIntent {
    static let title: LocalizedStringResource = "Add a note with Siri"
    
    @Parameter(title: "Note Title")
    var noteTitle: String
    
    @Parameter(title: "Note Content")
    var noteContent: String
    
    

    func perform() async throws -> some IntentResult & ProvidesDialog & ShowsSnippetView {
        // Create a MainViewModel instance
        let viewModel = await SiriViewModel()
          
        // Create a new note with the provided title, content, and image data
        let newNote = Post(postId:"",title: noteTitle, content: noteContent, date:Date(), images:nil )

        // Save the note using the viewModel
        try await viewModel.writeValuesToUserDefaults(note: newNote)

        // Provide feedback to the user through Siri
        let dialog = IntentDialog("Your note has been saved successfully.")

        // Return a custom SwiftUI view showing the note
        let snippetView = NoteAddedView(post: newNote)

        return .result(dialog: dialog, view: snippetView)
    }
}

