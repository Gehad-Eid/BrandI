//
//  AppEntities.swift
//  Challange1
//
//  Created by sumaiya on 25/10/2567 BE.
//

import Foundation

import Foundation
import AppIntents


struct NoteEntity: AppEntity {
    
    @Property(title: "Note Name")
    var title: String
    var content: String
    var id: Post.ID
    
    static let typeDisplayRepresentation: TypeDisplayRepresentation = "Post"
    
//    var displayRepresentation: DisplayRepresentation {
//        DisplayRepresentation(title: LocalizedStringResource(stringLiteral: title))
//    }
    //with displaythe title and content
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(title)",
                              subtitle: "\(content)")
    }
    
    static var defaultQuery = NoteQuery()
    
    // Correctly initialize properties
    init(note: Post) {
        self.id = note.id
        self.content = note.content
        self.title = note.title
        
    }
}
//
//struct NoteQuery: EntityQuery {
//    func entities(for identifiers: [NoteEntity.ID]) async throws -> [NoteEntity] {
//        // Iterate over the identifiers and use trail(with:) to find the notes
//        let notes = identifiers.compactMap { id in
//            MainViewModel.shared.trail(with: id) // Get the Note? for each identifier
//        }
//
//        // Map the notes to NoteEntity objects
//        return notes.map { note in
//            NoteEntity(note: note)
//        }
//    }
//}

struct NoteQuery: EntityQuery {
    @MainActor
    func entities(for identifiers: [NoteEntity.ID]) async throws -> [NoteEntity] {
        // Iterate over the identifiers and use trail(with:) to find the notes
        let notes = try await withThrowingTaskGroup(of: Post?.self) { group in
            for id in identifiers {
                group.addTask {
                    await SiriViewModel.shared.trail(with: id) // Get the Note? for each identifier
                }
            }
            
            var results: [Post?] = []
            for try await note in group {
                results.append(note)
            }
            return results
        }
        
        // Map the notes to NoteEntity objects
        return notes.compactMap { $0 }.map { note in
            NoteEntity(note: note)
        }
    }
}


extension NoteQuery: EnumerableEntityQuery {

        func allEntities() async throws -> [NoteEntity] {
            await SiriViewModel.shared.storedNotes.map {
                NoteEntity(note: $0)
                
            }
        }
    
}

