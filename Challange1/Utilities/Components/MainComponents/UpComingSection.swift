//
//  UpComingSection.swift
//  Challange1
//
//  Created by sumaiya on 21/10/2567 BE.
//


import SwiftUI

struct UpcomingSection: View {
//    let items: [Any] // Array to hold both Post and Event types
    @ObservedObject var vm: AgendaViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Upcoming")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, -190)
            
            TabView {
                ForEach(vm.upcomingItems?.indices ?? 0..<0, id: \.self) { index in
                    if let item = vm.upcomingItems?[index] {
                        UpcomingCard(item: item, vm: vm)
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
        UpcomingSection(vm: AgendaViewModel())
    }
}

