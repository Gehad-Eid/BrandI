//
//  OpenNoteIntent.swift
//  Challange1
//
//  Created by sumaiya on 25/10/2567 BE.
//

import Foundation
import AppIntents


struct OpenNoteIntent: AppIntent,OpenIntent {
    static var title: LocalizedStringResource = "Open Note with parameter"
    //the name showen in the parameter that user would like ro select
    @Parameter(title: "Notes")
    //the entity it mean the options "my notes list"
    var target: NoteEntity
    func perform() async throws -> some IntentResult {
        try await SiriViewModel.shared.navigate(to:target.id)
        return .result()
    }
    //to create the summary
    static var parameterSummary: some ParameterSummary {
        Summary("Open\(\.$target)")
        
    }
}

