//
//  AppShortCuts.swift
//  Challange1
//
//  Created by sumaiya on 25/10/2567 BE.
//

import Foundation

import AppIntents

struct AddNoteShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            //the intent will be from App Intent that we will define -- whole the process
            intent: AddPostIntent(),
            phrases: [
                "Create a new \(.applicationName) post",
                "Start a new \(.applicationName) post",
                "Write a new \(.applicationName) post"
            ],
            shortTitle: "Add a note",
            systemImageName: "pencil"
        )
        
        AppShortcut(
            intent: OpenPostIntent(),
            phrases: ["Open my \(.applicationName) posts",
                      "View my posts in \(.applicationName) ",
                      "List my posts on \(.applicationName) ",
                      "Show me my posts in  \(.applicationName) ",
                     ],
            shortTitle: "Open post",
            systemImageName: "book"
        )
    }
}
        
        //
        /// `GetTrailInfo` allows people to quickly check the conditions on their favorite trails.
        //        AppShortcut(intent: GetTrailInfo(), phrases: [
        //            "Get \(\.$post) conditions with \(.applicationName)",
        //            "Get conditions on \(\.$post) with \(.applicationName)"
        //        ],
        //        shortTitle: "Get Conditions",
        //        systemImageName: "cloud.rainbow.half",
        //        parameterPresentation: ParameterPresentation(
        //            for: \.$post,
        //            summary: Summary("Get \(\.$post) conditions"),
        //            optionsCollections: {
        //                OptionsCollection(NoteQuery(), title: "Favorite Trails", systemImageName: "cloud.rainbow.half")
        //            }
        //        ))
        
//    }
//}
