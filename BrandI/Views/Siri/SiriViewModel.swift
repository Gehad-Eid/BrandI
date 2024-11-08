//
//  SiriViewModel.swift
//  Challange1
//
//  Created by sumaiya on 25/10/2567 BE.
//

import Foundation
import SwiftUICore
import Observation

@MainActor
@Observable class SiriViewModel: ObservableObject, Sendable  {
    var storedPosts: [Post] = []
    var selectedPost: Post?
    var showPostDetail: Bool = false

    static let shared = SiriViewModel()
    
    private let keyStoredPosts = "storedPosts"
    private let addPostVM = AddPostViewModel()
    private let agendaVM = AgendaViewModel()
    

    init() {
        Task {
            try await readValuesFromDB()
        }
    }
    
    
    func readValuesFromDB() async throws {
        if let userID = UserDefaults.standard.string(forKey: "userID") {
            try await agendaVM.loadPosts(userId: userID)
            
            storedPosts = agendaVM.posts ?? []
            
            print("Successfully fetched \(storedPosts.count) posts for userID: \(userID)")
      
            
            for post in storedPosts {
                print("Post ID: \(post.postId), Title: \(post.title), Content: \(post.content)")
            }
            
        } else {
            print("Failed to retrieve posts: userID not found")
        }
    }
        
    //get the note by Id
    func openPostByID(_ id: String) async throws -> Post? {
        storedPosts.first { $0.postId == id }
//        guard let userID = UserDefaults.standard.string(forKey: "userID") else { return nil }
//        
//        // to get the post by id
//        return try await agendaVM.loadPostById(userId: userID,postId: id)
//        
        
    }
    
//return storedNotes.first { $0.id == id }
//    func trail(with identifier: Post.ID) -> Post? {
//        return storedNotes.first { $0.id == identifier }
//    }
    
    @MainActor
    func trail(with identifier: String) async -> Post? {
        if storedPosts.isEmpty {
            do {
                try await readValuesFromDB()
                print("💖 Posts loaded from Firebase.")
            } catch {
                print("❌ Failed to load posts from Firebase: \(error)")
                return nil
            }
        }
        
        guard let post = storedPosts.first(where: { $0.postId == identifier }) else {
            print("❌ No post found with identifier: \(identifier)")
            return nil
        }
        return post
    }



    
    func navigate(to id: String) async throws {
        if let post = storedPosts.first(where: { $0.postId == id }) {
            DispatchQueue.main.async {
                self.selectedPost = post
                self.showPostDetail = true
                print("Navigating to post with title: \(post.title), \(post.content)")
            }
        }
    }
//        guard let userID = UserDefaults.standard.string(forKey: "userID") else { return }
//        
        // to get the post by id
//        if let post = try await agendaVM.loadPostById(userId: userID, postId: id) {
//            DispatchQueue.main.async {
//                self.selectedNote = post
//                self.showNoteDetail = true // Activate navigation
//                print("Navigating to note with title: \(post.title)")
//            }
//        }
        
        
        
//        if let note = storedNotes.first(where: { $0.id == id }) {
//            DispatchQueue.main.async {
//                self.selectedNote = note
//                self.showNoteDetail = true // Activate navigation
//                print("Navigating to note with title: \(note.title)")
//            }
//        }
//    }



   
    func addPostToDB(note: Post) async throws {
        if let userID = UserDefaults.standard.string(forKey: "userID") {
            
            // Creat a doc in firestore and save it's ID and doc refrance
            let docInfo = UserManager.shared.createPostIdAndDocument(userID: userID)
            
            //Create the post
            let postId = try await UserManager.shared.addNewPost(userID: userID, post: note, docInfo: docInfo)
            
            try await readValuesFromDB()

        } else {
            print("vm.addPost(userId: userID!) failed")
        }
    }
}
