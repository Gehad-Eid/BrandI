//
//  CardViewSection.swift
//  Challange1
//
//  Created by sumaiya on 21/10/2567 BE.
//

import SwiftUI

struct CardViewSection: View {
    @ObservedObject var vm: AgendaViewModel
    @State private var selectedTab = 1
    
//    = [
//        Post(
//            postId: "1",
//            title: "Coffee Poster ☕️",
//            content: "☕✨ Happy Coffee Day! ✨☕ Today, we celebrate the brew that fuels our mornings...",
//            date: Date(),
//            images: ["coffeeImage"],
//            platforms: [.instagram, .facebook, .linkedin],
//            recommendation: "Keep up the caffeine content for more engagement!",
//            isDraft: false
//        ),
//        Post(
//            postId: "2",
//            title: "Tea Poster 🍵",
//            content: "🍵✨ Tea time is a moment to relax, unwind, and sip the calming flavors of your favorite brew...",
//            date: Date(),
//            images: ["teaImage"],
//            platforms: [.twitter, .snapchat],
//            recommendation: "Add an emoji or two for fun!",
//            isDraft: false
//        ),
//        Post(
//            postId: "3",
//            title: "Juice Poster 🥤",
//            content: "🥤✨ Freshly squeezed juice to brighten up your day and give you that boost of energy...",
//            date: Date(),
//            images: ["juiceImage"],
//            platforms: [.tiktok, .instagram, .facebook],
//            recommendation: "Highlight the health benefits more!",
//            isDraft: false
//        )
//    ]
    
    var body: some View {
        VStack{
            HStack{
                Text(currentDateForSelectedTab())
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button("Show All") {
                    // Action
                    
                }
                .foregroundColor(Color("BabyBlue"))
            }
            .padding(.bottom,-100)
            
            TabView(selection: $selectedTab) {
                DailyCardView(posts: vm.yesterdayPosts ?? [])
                    .padding()
                    .tag(0)
                
                DailyCardView(posts: vm.todayPosts ?? [])
                    .padding()
                    .tag(1)
                
                DailyCardView(posts: vm.tomorrowPosts ?? [])
                    .padding()
                    .tag(2)
                
            }
            //TODO: the padding shit
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .accentColor(Color("BabyBlue"))
            .frame(height: 460)
            .padding(.top, -80)
            .onAppear {
                selectedTab = 1 // Start at the "Today" tab
            }
        }
    }
    
    // Function to get the correct date string for the selected tab
        private func currentDateForSelectedTab() -> String {
            let date: Date?
            
            switch selectedTab {
            case 0:
                date = vm.yesterdayPosts?.first?.date
            case 1:
                date = vm.todayPosts?.first?.date
            case 2:
                date = vm.tomorrowPosts?.first?.date
            default:
                date = nil
            }
            
            if let date = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "EEEE, MMM d"
                return formatter.string(from: date)
            } else {
                return "No Date"
            }
        }
}

#Preview {
    CardViewSection(vm: AgendaViewModel())
}


//struct DailyCardView:View{
//    var body: some View{
//        ZStack {
//                 // First card (no offset)
//                 ReusableCardView(
//                     title: "Coffee Poster ☕️",
//                     imageName: "Intagram icon Dark",
//                     imageName2: "Linkedin icon Light",
//                     description: "☕✨ Happy Coffee Day! ✨☕ Today, we celebrate the brew that fuels our mornings...",
//                     backgroundColor: Color("BabyBlue"),
//                     destination: AnyView(CalendarView())
//                 )
//                 
//                 // Second card (slightly down)
//                 ReusableCardView(
//                     title: "Tea Poster 🍵",
//                     imageName: "Intagram icon Dark",
//                     description: "🍵✨ Tea time is a moment to relax, unwind, and sip the calming flavors of your favorite brew...",
//                     backgroundColor: Color("BabyBlue"),
//                     destination: AnyView(CalendarView())
//                 )
//                 .offset(y: 40)
//                 
//                 // Third card (further down)
//                 ReusableCardView(
//                     title: "Juice Poster 🥤",
//                     imageName: "Intagram icon Dark",
//                     description: "🥤✨ Freshly squeezed juice to brighten up your day and give you that boost of energy...",
//                     backgroundColor: Color("BabyBlue"),
//                     destination: AnyView(CalendarView())
//                 )
//                 .offset(y: 80)
//             }
//    }
//}


//Card Component


//struct ReusableCardView: View {
//    var title: String
//    var imageName: String
//    var imageName2: String?
//    var imageName3: String?
//    var description: String
//    var backgroundColor: Color
//    var destination: AnyView // Add destination view
//
//    var body: some View {
//        NavigationLink(destination: destination) { // Use NavigationLink for navigation
//            VStack(spacing: 0) {
//                // Title & Platform
//                HStack {
//                    Text(title)
//                        .padding()
//                    Spacer()
//                    HStack {
//                        Image(imageName3 ?? "")
//                            .resizable()
//                            .frame(width: 20, height: 20)
//
//                        Image(imageName2 ?? "")
//                            .resizable()
//                            .frame(width: 20, height: 20)
//
//                        Image(imageName)
//                            .resizable()
//                            .frame(width: 20, height: 20)
//                    }
//                    .padding()
//                }
//                .frame(width: 330, height: 50)
//                .background(Color.white)
//                .clipShape(TopCornersRoundedRectangle(radius: 18))
//                .shadow(color: Color.black, radius: 1, x: 0.4, y: 0.4)
//
//                // Details
//                VStack(alignment: .leading) {
//                    HStack {
//                        Text(description)
//                            .foregroundColor(Color.white)
//                            .padding(.top, 16)
//                            .padding(.leading, 16)
//                        Spacer()
//                    }
//                    Spacer()
//                }
//                .frame(width: 330, height: 180)
//                .background(backgroundColor)
//                .clipShape(BottomCornersRoundedRectangle(radius: 18))
//                .shadow(color: Color.black, radius: 0.1, x: 0.5, y: 0.5)
//            }
//        }
//        .buttonStyle(PlainButtonStyle()) // Remove default button styling
//    }
//}

