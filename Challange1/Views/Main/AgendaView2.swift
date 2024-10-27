//
//  AgendaView.swift
//  Challange1
//
//  Created by Gehad Eid on 10/10/2024.
//

import SwiftUI

struct AgendaView2: View {
    
    @StateObject private var vm = AgendaViewModel()
    @StateObject private var main_vm = MainViewModel()
    
    @State private var showingAddPostView = false
    
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
                        AddPostView(userId: main_vm.user?.userId ?? "")
                    }
                }
                .padding()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("2 Events \( main_vm.user?.userId ?? "")")
                            .font(.caption)
                        Text("3 Posts \(vm.posts?.count)")
                            .font(.caption)
                        Text("1 Unfinished Post \(vm.events?.count)")
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
                            WalletCardView(post: post, id: main_vm.user?.userId ?? "")
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
                try await main_vm.loadCurrentUser()
                try await vm.loadPosts(userId:  main_vm.user?.userId ?? "")
                try await vm.loadEvents(userId:  main_vm.user?.userId ?? "")
            }
        }
    }
}

struct WalletCardView: View {
    let post: Post
    let id: String
    
    var body: some View {
        NavigationLink(destination: PostView(post: post, userId: id)) { // Link to the detail view
            VStack(alignment: .leading) {
                HStack {
                    Text(post.title)
                        .font(.title3)
                        .bold()
                    Spacer()
                    if let platforms = post.platforms {
                        ForEach(platforms, id: \.self) { platform in
                            PlatformIcon(platform: platform.rawValue)
                        }
                    }
                }
                .padding(.bottom, 4)
                
                Text(post.postId)
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


struct AgendaView_Previews: PreviewProvider {
    static var previews: some View {
        AgendaView2()
    }
}

