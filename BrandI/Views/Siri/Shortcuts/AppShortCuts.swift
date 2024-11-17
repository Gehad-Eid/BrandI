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
            shortTitle: "Create a post",
            systemImageName: "pencil"
        )
        
        //        AppShortcut(
        //            intent: OpenPostIntent(),
        //            phrases: ["Open my \(.applicationName) posts",
        //                      "View my posts in \(.applicationName) ",
        //                      "List my posts on \(.applicationName) ",
        //                      "Show me my posts in  \(.applicationName) ",
        //                     ],
        //            shortTitle: "Open post",
        //            systemImageName: "book"
        //        )
        
        //Get Post Info
        
        AppShortcut(intent: GetPostInfo(),
                    phrases: [
                        "Open \(\.$getpost) in \(.applicationName)",
                        "Open my \(.applicationName) post",
                        "Get post on \(\.$getpost) with \(.applicationName)",
                        "Get my post in \(.applicationName)",
                        "List my posts on \(.applicationName)",
                        "View my posts in \(.applicationName) ",
                    ],
                    shortTitle: "Open Post",
                    systemImageName: "note.text",
                    
                    parameterPresentation: ParameterPresentation(
                        for: \.$getpost,
                        summary: Summary("Get \(\.$getpost) "),
                        optionsCollections: {
                            OptionsCollection(PostQuery(), title: "Posts", systemImageName: "note.text")
                        }
                    ))
    }
}
