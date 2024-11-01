//
//  AppEntities.swift
//  Challange1
//
//  Created by sumaiya on 25/10/2567 BE.
//

import Foundation
import AppIntents


struct NoteEntity: AppEntity {
    
    @Property(title: "Note Name")
    var title: String
    var content: String
    var id: String
    
    static let typeDisplayRepresentation: TypeDisplayRepresentation = "Post"

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(title)",
                              subtitle: "\(content)")
    }
    
    static var defaultQuery = NoteQuery()
    
    // Correctly initialize properties
    init(post: Post) {
        self.id = post.postId
        self.content = post.content
        self.title = post.title
        
    }
}
//


struct NoteQuery: EntityQuery {
    @MainActor
//    func entities(for identifiers: [NoteEntity.ID]) async throws -> [NoteEntity] {
    func entities(for identifiers: [String]) async throws -> [NoteEntity] {
        let notes = try await withThrowingTaskGroup(of: Post?.self) { group in
            for id in identifiers {
                group.addTask {
                    await SiriViewModel.shared.trail(with: id)
                }
            }
            
            var results: [Post?] = []
            for try await post in group {
                results.append(post)
            }
            return results
        }
        
        // Map the posts to NoteEntity objects, filtering out nil values
        return notes.compactMap { $0 }.map {
            NoteEntity(post: $0)
        }
    }
}



extension NoteQuery: EnumerableEntityQuery {
    
    func allEntities() async throws -> [NoteEntity] {
        await SiriViewModel.shared.storedNotes.map {
            NoteEntity(post: $0)
            
        }
    }
}

