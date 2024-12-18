//
//  AddNoteIntent.swift
//  Challange1
//
//  Created by sumaiya on 25/10/2567 BE.
//

import Foundation
import AppIntents
import SwiftUI



struct PostAddedView: View {
    let post: Post
    
    var body: some View {
      
            VStack(spacing: 0) {
                // Title & Platforms
                HStack {
                    Text(post.title)
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                        .padding()
                    Spacer()
//                    Image("SiriIcon")
//                        .resizable()
//                        .frame(width:40 , height: 40)
//                        .padding(.trailing, 12)
//                        .shadow(color: Color.white, radius: 0.3, x: 1, y: 1)
                   
                }
                .background(Color("BabyBlue"))
                .frame(width: 330, height: 50)
                .background(Color.black)
                              .shadow(radius: 10, x: 10, y: 10)
                .clipShape(TopCornersRoundedRectangle(radius: 18))
              
                
                // Details
                VStack(alignment: .leading) {
                    HStack {
                        Text(post.content)
                            .foregroundColor(Color("Text"))
                            .padding(.top, 16)
                            .padding(.leading, 16)
                        Spacer()
                    }
                    Spacer()
                }
                .frame(width: 330, height: 180)
                .background(Color("BoxColor2"))
                .clipShape(BottomCornersRoundedRectangle(radius: 18))
                
            }.padding(.vertical, 16)
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 2, y: 2)
        }
  
    
}
#Preview {
    PostAddedView(post:Post(postId:"",title: "Hello World", content: "Hello World", date:Date(), images:nil, isDraft: true ))
}

//View for get post with Images and platforms

struct PostViewDialog: View {
    
    let post: Post
    @Environment(\.colorScheme) private var colorScheme // Get the current color scheme
    
    var body: some View {
        VStack(spacing: 0) {
            // Title & Platforms
            HStack {
                Text(post.title)
                    .foregroundColor(Color.white)
                    .fontWeight(.semibold)
                    .padding()
                
                Spacer()
                
                HStack {
                  
                    if let platforms = post.platforms {
                        ForEach(platforms.prefix(3), id: \.self) { platform in
                            Image(platform.iconName(for: colorScheme))
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }
                }
                .padding()
            }
            .background(Color("BabyBlue"))
            .frame(width: 330, height: 50)
            .clipShape(TopCornersRoundedRectangle(radius: 18))
            .shadow(radius: 10, x: 10, y: 10)
            
            // Details
            VStack(alignment: .leading) {
                HStack {
                    Text(post.content)
                        .foregroundColor(Color("Text"))
                        .padding(.top, 16)
                        .padding(.leading, 16)
                    Spacer()
                }
                Spacer()
               
                HStack{
                    Spacer()
                    
                    
//                    ZStack {
//                        // Ensure post.images is not nil or empty
//                        if let images = post.images, !images.isEmpty {
//                            ForEach(images.indices, id: \.self) { index in
//                                AsyncImage(url: URL(string: images[index].imageUrl)) { image in
//                                    image
//                                        .resizable()
//                                        .scaledToFill()
//                                        .frame(width: 40, height: 40)
//                                        .clipped()
//                                        .cornerRadius(8)
//                                        .overlay(
//                                            RoundedRectangle(cornerRadius: 10)
//                                                .stroke(Color.gray, lineWidth: 0.5)
//                                        )
//                                        // Stacked effect: Increase x-offset to make images overlap
//                                        .offset(x: CGFloat(index * 5), y: 10)
//                                        .zIndex(Double(index + 1))
//                                } placeholder: {
//                                    ProgressView()
//                                        .frame(width: 40, height: 40)
//                                        .clipped()
//                                        .cornerRadius(8)
//                                        .zIndex(Double(index + 1))
//                                }
//                            }
//                            
//                            // Display the "+X" label when there are more than 3 images
//                            if images.count > 3 {
//                                Text("\(images.count - 3)+")
//                                    .font(.system(size: 12, weight: .bold))
//                                    .foregroundColor(.white)
//                                    .padding(3)
//                                    .background(
//                                        RoundedRectangle(cornerRadius: 4)
//                                            .fill(Color.gray.opacity(0.9))
//                                    )
//                                    .offset(x: 20, y: 10)
//                                    .zIndex(100)
//                            }
//                        }
//                    }
//                    .frame(width: 40, height: 40)
//                    .padding(.bottom, 10)
//                    .frame(width: 40, height: 40)
                    
                    
                    
                }.padding(.trailing,30)
                    .padding(.bottom,10)
            }
            .frame(width: 330, height: 180)
            .background(Color("BoxColor2"))
            .clipShape(BottomCornersRoundedRectangle(radius: 18))
        }
        .padding(.vertical, 16)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 2, y: 2)
    }
}

#Preview {
    PostViewDialog(post:Post(postId:"",title: "Hello World", content: "Hello World", date:Date(), images:nil, isDraft: true ))
}
//here with custom view

struct AddPostIntent: AppIntent {
    static let title: LocalizedStringResource = "Add a post with Siri"
    
    @Parameter(title: "Post Title")
    var postTitle: String
    
    @Parameter(title: "Post Content")
    var postContent: String
    
    

    func perform() async throws -> some IntentResult & ProvidesDialog & ShowsSnippetView {
        // Create a MainViewModel instance
        let viewModel = await SiriViewModel()
          
        // Create a new note with the provided title, content, and image data
        let newNote = Post(postId:"",title: postTitle, content: postContent, date:Date(), images:nil, isDraft: true )

        // Save the note using the viewModel
        try await viewModel.addPostToDB(note: newNote)

        // Provide feedback to the user through Siri
        let dialog = IntentDialog("Got it! Your post has been saved as a draft.")

        // Return a custom SwiftUI view showing the note
        let snippetView = PostAddedView(post: newNote)

        return .result(dialog: dialog, view: snippetView)
    }
}

