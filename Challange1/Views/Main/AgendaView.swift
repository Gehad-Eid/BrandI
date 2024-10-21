//
//  AgendaView.swift
//  Challange1
//
//  Created by Gehad Eid on 10/10/2024.
//

import SwiftUI

@MainActor
final class AgendaViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    @Published private(set) var posts: [Post]? = nil
    
    func loadCurrentUser() async throws {
        let userDataResult = try FirebaseAuthManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userID: userDataResult.uid)
    }
    
    func loadPosts() async throws {
        guard let userId = user?.userId else { return }
        self.posts = try await UserManager.shared.getUserPosts(userID: userId)
    }
}

struct AgendaView: View {
    
    @State private var showingAddPostView = false
    
    @StateObject private var vm = AgendaViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Agenda")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    Button(action: {
                        showingAddPostView.toggle()
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                            .padding()
                            .background(Color.blue.opacity(0.3))
                            .clipShape(Circle())
                    }
                    .sheet(isPresented: $showingAddPostView) {
                        AddPostView(userId: vm.user?.userId ?? "")
                    }
                }
                .padding()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("2 Events \(vm.user?.userId)")
                            .font(.caption)
                        Text("3 Posts \(vm.posts?.count)")
                            .font(.caption)
                        Text("1 Unfinished Post")
                            .font(.caption)
                    }
                    Spacer()
                }
                .padding([.leading, .bottom])
                
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Tuesday, Sep 19")
                            .font(.headline)
                        
                        ForEach(vm.posts ?? []) { post in
                            WalletCardView(post: post)
                                .padding(.bottom, 8)
                        }
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
        }
        .onAppear() {
            Task {
                try await vm.loadCurrentUser()
                try await vm.loadPosts()
            }
        }
    }
}

struct WalletCardView: View {
    
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(post.title)
                    .font(.title3)
                    .bold()
                Spacer()
                if let platforms = post.platforms {
                    ForEach(platforms, id: \.self) { platform in
                        PlatformIcon(platform: platform)
                    }
                }
            }
            .padding(.bottom, 4)
            
            Text(post.content)
                .font(.body)
                .lineLimit(3)
                .padding(.bottom, 8)
            
            HStack {
                Text("Tomorrow")
                    .font(.caption)
                Spacer()
                Text(post.date, style: .date)
                    .font(.caption)
            }
            .padding(.top, 4)
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(10)
    }
}

struct PlatformIcon: View {
    let platform: String
    
    var body: some View {
        Image(systemName: iconForPlatform(platform))
            .resizable()
            .frame(width: 20, height: 20)
            .padding(.horizontal, 4)
    }
    
    func iconForPlatform(_ platform: String) -> String {
        switch platform {
        case "Instagram": return "camera"
        case "LinkedIn": return "person.2.fill"
        case "X": return "xmark.circle"
        default: return "globe"
        }
    }
}

// AddPostView will go here

struct AgendaView_Previews: PreviewProvider {
    static var previews: some View {
        AgendaView()
    }
}

