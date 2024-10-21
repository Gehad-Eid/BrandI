//
//  UpComingSection.swift
//  Challange1
//
//  Created by sumaiya on 21/10/2567 BE.
//


import SwiftUI

struct  UpcomingSection: View {
    init() {
         
           if let babyBlue = UIColor(named: "BabyBlue") {
               UIPageControl.appearance().currentPageIndicatorTintColor = babyBlue
             
               UIPageControl.appearance().pageIndicatorTintColor = UIColor(named: "GrayColor")
           }
       }
    var body: some View {
        VStack(alignment:.leading){
            Text("Upcoming")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom,-190)
                
            TabView{
                PostRow(postTitle: "Post Title", postDate: "20.9.2024",
                        postRemainDate: "Tomorrow",
                        imageName: "document.fill"
                        
                ) {
                    
                    print("Post tapped")
                }.padding()
               
                PostRow(postTitle: "Saudi National Day", postDate: "20.9.2024",
                        postRemainDate: "In 3 days",
                        imageName: "note"
                ) {
                    
                    print("Post tapped")
                }
               
                PostRow(postTitle: "Post Title", postDate: "20.9.2024",
                        postRemainDate: "In 3 days",
                        imageName: "document.fill"
                ) {
                    
                    print("Post tapped")
                }
               
            }.tabViewStyle(.page(indexDisplayMode: .always))
            
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                .accentColor(Color("BabyBlue"))
                .frame(height: 150)
                .padding(.top,-10)
                       
        }
    }
}

#Preview {
    UpcomingSection()
}


struct PostRow: View {
    var postTitle: String
    var postDate: String
    var postRemainDate : String
    var imageName: String
    var onTap: () -> Void

    var body: some View {
    
        HStack {
            VStack(alignment: .center) {
                Image(systemName: imageName)
                    .foregroundStyle(Color("BabyBlue"))
                    .font(.system(size: 30))
                
                Text(postRemainDate)
                    .foregroundStyle(Color("BabyBlue"))
                    .font(.system(size: 14))
                    .fontWeight(.medium)
            }
            .padding()
            
            VStack(alignment: .leading) {
                Text(postTitle)
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                Text(postDate)
                    .font(.caption)
                    .foregroundStyle(Color("GrayText"))
            }
        }
        .frame(width: 350, height: 80, alignment: .leading)
        .background(Color("BoxColor"))
        .cornerRadius(18)
       // .shadow(color: Color.black.opacity(0.1), radius: 0.1, x: 0, y: 0)
        .onTapGesture {
            onTap()
        }
    }
}

