//
//  UpComingSection.swift
//  Challange1
//
//  Created by sumaiya on 21/10/2567 BE.
//


import SwiftUI

struct UpcomingSection: View {
    @EnvironmentObject var vm: AgendaViewModel

//    let items: [Any] // Array to hold both Post and Event types
//    @ObservedObject var vm: AgendaViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Upcoming this week")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, -190)
//                .foregroundStyle(Color("GrayText"))
            
            TabView {
                ForEach(vm.upcomingItems?.indices ?? 0..<0, id: \.self) { index in
                    if let item = vm.upcomingItems?[index] {
                        UpcomingCard(item: item)
                            .padding()
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .accentColor(Color("BabyBlue"))
            .frame(height: 150)
            .padding(.top, -10)
        }
        .onAppear {
            if let babyBlue = UIColor(named: "BabyBlue") {
                UIPageControl.appearance().currentPageIndicatorTintColor = babyBlue
                UIPageControl.appearance().pageIndicatorTintColor = UIColor(named: "GrayColor")
            }
        }
    }
}
    
#Preview {
    NavigationStack {
        UpcomingSection(/*vm: AgendaViewModel()*/)
    }
}

