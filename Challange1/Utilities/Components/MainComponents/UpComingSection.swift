//
//  UpComingSection.swift
//  Challange1
//
//  Created by sumaiya on 21/10/2567 BE.
//


import SwiftUI

struct UpcomingSection: View {
    let items: [Any] // Array to hold both Post and Event types
    @ObservedObject var vm: AgendaViewModel

    init() {
        if let babyBlue = UIColor(named: "BabyBlue") {
            UIPageControl.appearance().currentPageIndicatorTintColor = babyBlue
            UIPageControl.appearance().pageIndicatorTintColor = UIColor(named: "GrayColor")
        }
        // Sample data for testing, replace this with your actual data
        self.items = [
            Post(postId: "1", title: "Post Title", content: "coco", date: Date(), images: [], platforms: [], recommendation: "", isDraft: false),
            Event(eventId: "1", title: "Saudi National Day", startDate: Date(), endDate: Date()),
            Event(eventId: "3", title: "Saudi day", startDate: Date(), endDate: Date()),
            Post(postId: "1", title: "Post Title", content: "tenttnet", date: Date(), images: [], platforms: [], recommendation: "", isDraft: false),
            Event(eventId: "3", title: "Saudi day", startDate: Date(), endDate: Date()),

        ]
        
        self.vm = AgendaViewModel()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Upcoming")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, -190)
            
            TabView {
                ForEach(items.indices, id: \.self) { index in
                    let item = items[index]
                    UpcomingCard(item: item, vm: vm)
                        .padding()
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .accentColor(Color("BabyBlue"))
            .frame(height: 150)
            .padding(.top, -10)
        }
    }
}
    
#Preview {
    NavigationStack {
        UpcomingSection()
    }
}

