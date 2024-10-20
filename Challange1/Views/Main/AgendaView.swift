//
//  AgendaView.swift
//  Challange1
//
//  Created by Gehad Eid on 10/10/2024.
//

import SwiftUI

//TODO: load user here

@MainActor
final class AgendaViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let userDataResult = try FirebaseAuthManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userID: userDataResult.uid)
    }
}

struct AgendaView: View {
    
    @State private var posts: [Post] = [
        Post(postId: "1", title: "post1", content: "contennnntttt ....", date: Date(), images: [""], platforms: ["LinkedIn"], recommendation: ""),
        
        Post(postId: "2", title: "Post2", content: "Instagram post about tech.", date: Date(), images: [""], platforms: ["Instagram"], recommendation: ""),
        
        Post(postId: "3", title: "Coffee Day", content: "Today, we celebrate the brew that fuels our mornings and warms our hearts. Whether you love it strong, sweet, iced, or hot, coffee is more than just a drink—it's a daily ritual, a moment of calm, and the perfect start to any day.", date: Date(), images: [""], platforms: ["Instagram", "X"], recommendation: "")
    ]
    
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
                        Text("2 Events \(vm.user?.events?.count)")
                            .font(.caption)
                        Text("3 Posts \(vm.user?.posts?.count)")
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
                        
                        ForEach(posts) { post in
                            WalletCardView(post: post)
                                .padding(.bottom, 8)
                        }
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
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

