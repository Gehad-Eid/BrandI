//
//  CardViewSection.swift
//  Challange1
//
//  Created by sumaiya on 21/10/2567 BE.
//

import SwiftUI

struct CardViewSection: View {
    
    var body: some View {
        let date : String = "Tuesday ,Sep 19"
        VStack{
            HStack{
                Text(date)
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
                Button("Show All") {
                    print("Show All")
                }.foregroundColor(Color("BabyBlue"))

            }.padding(.bottom,-100)
            
            TabView {
                DailyCardView()
                    .padding()

                DailyCardView()
                    .padding()

                DailyCardView()
                    .padding()

            }.tabViewStyle(.page(indexDisplayMode: .always))
             // Remove the background color
             .indexViewStyle(.page(backgroundDisplayMode: .interactive))
             .accentColor(Color("BabyBlue"))
             .frame(height: 460)
             .padding(.top,-90)
     
         
            
            
        }
        
    }
}

#Preview {
    CardViewSection()
}


struct DailyCardView:View{
    var body: some View{
        ZStack {
                 // First card (no offset)
                 ReusableCardView(
                     title: "Coffee Poster ☕️",
                     imageName: "Intagram icon Dark",
                     imageName2: "Linkedin icon Light",
                     description: "☕✨ Happy Coffee Day! ✨☕ Today, we celebrate the brew that fuels our mornings...",
                     backgroundColor: Color("BabyBlue"),
                     destination: AnyView(CalendarView())
                 )
                 
                 // Second card (slightly down)
                 ReusableCardView(
                     title: "Tea Poster 🍵",
                     imageName: "Intagram icon Dark",
                     description: "🍵✨ Tea time is a moment to relax, unwind, and sip the calming flavors of your favorite brew...",
                     backgroundColor: Color("BabyBlue"),
                     destination: AnyView(CalendarView())
                 )
                 .offset(y: 40)
                 
                 // Third card (further down)
                 ReusableCardView(
                     title: "Juice Poster 🥤",
                     imageName: "Intagram icon Dark",
                     description: "🥤✨ Freshly squeezed juice to brighten up your day and give you that boost of energy...",
                     backgroundColor: Color("BabyBlue"),
                     destination: AnyView(CalendarView())
                 )
                 .offset(y: 80)
             }
    }
}
//Corner
struct TopCornersRoundedRectangle: Shape {
    var radius: CGFloat = 18
    var corners: UIRectCorner = [.topLeft, .topRight]

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
struct BottomCornersRoundedRectangle: Shape {
    var radius: CGFloat = 18
    var corners: UIRectCorner = [.bottomLeft, .bottomRight]

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

//Card Component



struct ReusableCardView: View {
    var title: String
    var imageName: String
    var imageName2: String?
    var imageName3: String?
    var description: String
    var backgroundColor: Color
    var destination: AnyView // Add destination view

    var body: some View {
        NavigationLink(destination: destination) { // Use NavigationLink for navigation
            VStack(spacing: 0) {
                // Title & Platform
                HStack {
                    Text(title)
                        .padding()
                    Spacer()
                    HStack {
                        Image(imageName3 ?? "")
                            .resizable()
                            .frame(width: 20, height: 20)

                        Image(imageName2 ?? "")
                            .resizable()
                            .frame(width: 20, height: 20)

                        Image(imageName)
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    .padding()
                }
                .frame(width: 330, height: 50)
                .background(Color.white)
                .clipShape(TopCornersRoundedRectangle(radius: 18))
                .shadow(color: Color.black, radius: 1, x: 0.4, y: 0.4)

                // Details
                VStack(alignment: .leading) {
                    HStack {
                        Text(description)
                            .foregroundColor(Color.white)
                            .padding(.top, 16)
                            .padding(.leading, 16)
                        Spacer()
                    }
                    Spacer()
                }
                .frame(width: 330, height: 180)
                .background(backgroundColor)
                .clipShape(BottomCornersRoundedRectangle(radius: 18))
                .shadow(color: Color.black, radius: 0.1, x: 0.5, y: 0.5)
            }
        }
        .buttonStyle(PlainButtonStyle()) // Remove default button styling
    }
}

#Preview {
    ReusableCardView(
        title: "Coffee Poster ☕️",
        imageName: "Intagram icon Dark",
        description: "☕✨ Happy Coffee Day! ✨☕ Today, we celebrate the brew that fuels our mornings...",
        backgroundColor: Color("BabyBlue"), destination: AnyView(MainView())
    )
}

