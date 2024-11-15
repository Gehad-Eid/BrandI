//
//  GetPostIntent.swift
//  Challange1
//
//  Created by sumaiya on 27/10/2567 BE.
//

import Foundation
import AppIntents


struct GetPostInfo: AppIntent {
    
    static var title: LocalizedStringResource = "Get Post Details"
    static var description = IntentDescription("Provides complete details on a post")
                                       
    static var parameterSummary: some ParameterSummary {
        Summary("Get information on \(\.$getpost)")
    }

    @Parameter(title: "Post", description: "The post to get information on.")
    var getpost: PostEntity
    
    func perform() async throws -> some IntentResult & ReturnsValue<PostEntity> & ProvidesDialog & ShowsSnippetView {
       
        let postData = await SiriViewModel.shared.trail(with: getpost.id)
        
        guard let postData else {
            throw NSError(domain: "com.example.AppIntents", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to load post details"])
        }
        
        let snippet = PostViewDialog(post: postData)
        
        let dialog = IntentDialog(
            full: "You’re viewing the latest details for \(getpost.title)!",
            supporting: "Here’s everything you need to know about  \(getpost.title)."
        )

        return .result(value: getpost, dialog: dialog, view: snippet)
    }
}

