//
//  SiriViewModel.swift
//  Challange1
//
//  Created by sumaiya on 25/10/2567 BE.
//

import Foundation
import SwiftUICore
//MainViewModel is a class that conforms to the ObservableObject protocol, meaning it can be observed for changes by SwiftUI views. When the data in this class changes, the views that observe it will update automatically.

//storedNotes: An array of String that holds the notes. It is marked with @Published, meaning any changes to this property will automatically notify any observing views to re-render.


//struct Note: Identifiable, Codable, Hashable {
//    let id: UUID
//    let title: String
//    let content: String
//    let image:Data?
//  
//    
//    
//    init(title: String, content: String, image : Data?) {
//        self.id = UUID()
//        self.title = title
//        self.content = content
//        self.image = image
//    }
//   
//}
@MainActor
class SiriViewModel: ObservableObject, Sendable  {
    @Published var storedNotes: [Post] = []
    @Published var selectedNote: Post?
    //private let keyStoredNotes = "storedNotes"
    //to observed all the main
    static let shared = SiriViewModel()
    @Published var showNoteDetail: Bool = false
    
    private let  addPostVM = AddPostViewModel()
    private let  agendaVM = AgendaViewModel()
    

    func initialize() async throws {
            try await readValuesFromDB()
        }
    
    
    func readValuesFromDB() async throws {
        if let userID = UserDefaults.standard.string(forKey: "userID") {
            try await agendaVM.loadPosts(userId: userID)
            
            storedNotes = agendaVM.posts ?? []
            
            print("Successfully fetched \(storedNotes.count) posts for userID: \(userID)")
            
            for post in storedNotes {
                print("Post ID: \(post.id), Title: \(post.title), Content: \(post.content)")
            }
        } else {
            print("Failed to retrieve posts: userID not found in UserDefaults")
        }
    }
        
//        if let data = UserDefaults.standard.data(forKey: keyStoredNotes) {
//            if let decodedData = try? JSONDecoder().decode([Note].self, from: data) {
//                storedNotes = decodedData
//            }
//        }
        
    //get the note by Id
    func openPostByID(_ id: String) async throws -> Post? {
        guard let userID = UserDefaults.standard.string(forKey: "userID") else { return nil }
        
        // to get the post by id
        return try await agendaVM.loadPostById(userId: userID,postId: id)
        
        
    }
    
//return storedNotes.first { $0.id == id }
//    func trail(with identifier: Post.ID) -> Post? {
//        return storedNotes.first { $0.id == identifier }
//    }
    
    @MainActor
    func trail(with identifier: String) async -> Post? {
//        if storedNotes.isEmpty {
            try? await readValuesFromDB() // Fetch from Firebase if needed
//        }
        return storedNotes.first { $0.postId == identifier }
    }


    
    func navigate(to id: String) async throws {
        guard let userID = UserDefaults.standard.string(forKey: "userID") else { return }
        
        // to get the post by id
        if let post = try await agendaVM.loadPostById(userId: userID, postId: id) {
            DispatchQueue.main.async {
                self.selectedNote = post
                self.showNoteDetail = true // Activate navigation
                print("Navigating to note with title: \(post.title)")
            }
        }
        
//        if let note = storedNotes.first(where: { $0.id == id }) {
//            DispatchQueue.main.async {
//                self.selectedNote = note
//                self.showNoteDetail = true // Activate navigation
//                print("Navigating to note with title: \(note.title)")
//            }
//        }
    }



   
    func writeValuesToUserDefaults(note: Post) async throws {
        if let userID = UserDefaults.standard.string(forKey: "userID") {
            try await readValuesFromDB()
            
            // Creat a doc in firestore and save it's ID and doc refrance
            let docInfo = UserManager.shared.createPostIdAndDocument(userID: userID)
            
            //Create the post
            let postId = try await UserManager.shared.addNewPost(userID: userID, post: note, docInfo: docInfo)
        } else {
            print("vm.addPost(userId: userID!) failed")
        }
    }
}
