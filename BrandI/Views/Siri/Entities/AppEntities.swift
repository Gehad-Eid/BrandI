//
//  AppEntities.swift
//  Challange1
//
//  Created by sumaiya on 25/10/2567 BE.
//

import Foundation
import AppIntents


struct PostEntity: AppEntity {
    
    @Property(title: "Post Name")
    var title: String
    var content: String
    var id: String
    
    static let typeDisplayRepresentation: TypeDisplayRepresentation = "Post"

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(title)",
                              subtitle: "\(content)")
    }
    
    static var defaultQuery = PostQuery()
    
    // Correctly initialize properties
    init(post: Post) {
        self.id = post.postId
        self.content = post.content
        self.title = post.title
        
    }
}


struct PostQuery: EntityQuery {
    @MainActor
    func entities(for identifiers: [PostEntity.ID]) async throws -> [PostEntity] {
        // Iterate over the identifiers and use trail(with:) to find the notes
        let posts = try await withThrowingTaskGroup(of: Post?.self) { group in
            for id in identifiers {
                group.addTask {
                    await SiriViewModel.shared.trail(with: id) // Get the Note? for each identifier
                }
            }
            
            var results: [Post?] = []
            for try await post in group {
                results.append(post)
            }
            return results
        }
        
        // Map the notes to NoteEntity objects
        return posts.compactMap { $0 }.map { post in
            PostEntity(post: post)
        }
    }
}

extension PostQuery: EnumerableEntityQuery {
    func allEntities() async throws -> [PostEntity] {
        await SiriViewModel.shared.storedPosts.map {
            PostEntity(post: $0)
            
        }
    }
}


//    func entities(for identifiers: [NoteEntity.ID]) async throws -> [NoteEntity] {
//    func entities(for identifiers: [String]) async throws -> [PostEntity] {
//        let notes = try await withThrowingTaskGroup(of: Post?.self) { group in
//            for id in identifiers {
//                group.addTask {
//                    await SiriViewModel.shared.trail(with: id)
//                }
//            }
//            
//            var results: [Post?] = []
//            for try await post in group {
//                results.append(post)
//            }
//            return results
//        }
//        
//        // Map the posts to NoteEntity objects, filtering out nil values
//        return notes.compactMap { $0 }.map {
//            PostEntity(post: $0)
//        }
//    }
//}





