//
//  GetPostIntent.swift
//  Challange1
//
//  Created by sumaiya on 27/10/2567 BE.
//

import Foundation
import AppIntents

//struct GetTrailInfo: AppIntent {
//    
//    static var title: LocalizedStringResource = "Get Post Information"
//    static var description = IntentDescription("Provides complete details on a post",
//                                               categoryName: "Discover")
//    
//   
//    static var parameterSummary: some ParameterSummary {
//        Summary("Get information on \(\.$post)")
//    }
//
//   
//    @Parameter(title: "Posts", description: "The post to get information on.")
//    var post: NoteEntity
//    
//    @Dependency
//    private var siriViewModel: SiriViewModel
//    
//   
//    func perform() async throws -> some IntentResult & ReturnsValue<NoteEntity> & ProvidesDialog & ShowsSnippetView {
//        let trailData = await siriViewModel.trail(with: post.id)
//       
//        let snippet = NoteDetailView(note: trailData!)
//        
//        let dialog = IntentDialog(full: "The latest conditions reported for \(post.title) ",
//                                  supporting: "Here's the latest information on trail conditions.")
//        
//        return .result(value: post, dialog: dialog, view: snippet)
//    }
//}

