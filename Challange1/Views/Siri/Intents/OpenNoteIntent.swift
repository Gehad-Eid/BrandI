//
//  OpenNoteIntent.swift
//  Challange1
//
//  Created by sumaiya on 25/10/2567 BE.
//

import Foundation
import AppIntents


struct OpenPostIntent: AppIntent, OpenIntent {
    static var title: LocalizedStringResource = "Open Post with parameter"
    //the name showen in the parameter that user would like ro select
    @Parameter(title: "Posts")
    var target: PostEntity
    
    func perform() async throws -> some IntentResult {
        try await SiriViewModel.shared.navigate(to: target.id)
        return .result()

//        // Add a confirmation dialog to end the loop
//                return .result(dialog: IntentDialog("Here is your post in the app."))
    }
    
    //to create the summary
    static var parameterSummary: some ParameterSummary {
        Summary("Open \(\.$target)")
    }
}

