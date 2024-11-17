////
////  CardViewSection.swift
////  Challange1
////
////  Created by sumaiya on 21/10/2567 BE.
////
//
//import SwiftUI
//
//struct CardViewSection: View {
//    @EnvironmentObject var vm: AgendaViewModel
//
////    @ObservedObject var vm: AgendaViewModel
//    @State private var selectedTab = 1
//    @Binding var mainTabSelection: Int
//    
//    var body: some View {
//        VStack{
//            HStack{
//                Text(currentDateForSelectedTab())
//                    .font(.title3)
//                    .fontWeight(.bold)
//                
//                Spacer()
//                
//                Button("Show All") {
//                    print("pressed")
//                    mainTabSelection = 1 // Switch to Calendar tab in MainTabView
//                }
//                .foregroundColor(Color("BabyBlue"))
//            }
//            .zIndex(1) // Bring to front
//            .padding(.bottom,-100)
//            
//            TabView(selection: $selectedTab) {
//                DailyCardView(posts: vm.yesterdayPosts ?? [], showingPostView: $showingPostView)
//                    .padding()
//                    .tag(0)
//                
//                DailyCardView(posts: vm.todayPosts ?? [])
//                    .padding()
//                    .tag(1)
//                
//                DailyCardView(posts: vm.tomorrowPosts ?? [])
//                    .padding()
//                    .tag(2)
//                
//            }
//            .tabViewStyle(.page(indexDisplayMode: .always))
//            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
//            .accentColor(Color("BabyBlue"))
//            .frame(height: 530)
//            .padding(.top, -130)
//            .onAppear {
//                selectedTab = 1 // Start at the "Today" tab
//            }
//        }
//    }
//    
//    // Function to get the correct date string for the selected tab
//    private func currentDateForSelectedTab() -> String {
//        let date: Date?
//        
//        switch selectedTab {
//        case 0:
//            date = vm.yesterdayPosts?.first?.date
//        case 1:
//            date = vm.todayPosts?.first?.date
//        case 2:
//            date = vm.tomorrowPosts?.first?.date
//        default:
//            date = nil
//        }
//        
//        if let date = date {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "EEEE, MMM d"
//            return formatter.string(from: date)
//        } else {
//            return "No Date"
//        }
//    }
//}
////    struct CardViewSection: View {
////    @ObservedObject var vm: AgendaViewModel
////    @State private var selectedTab = 1
////    @Binding var mainTabSelection: Int
////        
////    var body: some View {
////        VStack{
////            HStack{
////                Text(currentDateForSelectedTab())
////                    .font(.title3)
////                    .fontWeight(.bold)
////                
////                Spacer()
////                
////                Button("Show All") {
////                    print("pressed")
////                    mainTabSelection = 1 // Switch to Calendar tab in MainTabView
////                }
////                .foregroundColor(Color("BabyBlue"))
////            }
////            .zIndex(1) // Bring to front
////            .padding(.bottom,-10)
////            .border(Color.red) // Debugging border to check layout
////            
////            TabView(selection: $selectedTab) {
////                DailyCardView(posts: vm.yesterdayPosts ?? [])
////                    .padding()
////                    .tag(0)
////                
////                DailyCardView(posts: vm.todayPosts ?? [])
////                    .padding()
////                    .tag(1)
////                
////                DailyCardView(posts: vm.tomorrowPosts ?? [])
////                    .padding()
////                    .tag(2)
////                
////            }
////            .tabViewStyle(.page(indexDisplayMode: .always))
////            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
////            .accentColor(Color("BabyBlue"))
////            .frame(height: 390)
//////            .frame(maxHeight: .infinity)
////            .background(Color.yellow)
//////            .padding(.top, -130)
////            .onAppear {
////                selectedTab = 0 // Start at the "Today" tab
////            }
////        }
////        .frame(maxHeight: .infinity)
////    }
////    
////    // Function to get the correct date string for the selected tab
////        private func currentDateForSelectedTab() -> String {
////            let date: Date?
////            
////            switch selectedTab {
////            case 0:
////                date = vm.yesterdayPosts?.first?.date
////            case 1:
////                date = vm.todayPosts?.first?.date
////            case 2:
////                date = vm.tomorrowPosts?.first?.date
////            default:
////                date = nil
////            }
////            
////            if let date = date {
////                let formatter = DateFormatter()
////                formatter.dateFormat = "EEEE, MMM d"
////                return formatter.string(from: date)
////            } else {
////                return "No Date"
////            }
////        }
////}
//
//#Preview {
//    CardViewSection(/*vm: AgendaViewModel(),*/ mainTabSelection: .constant(0))
//}
