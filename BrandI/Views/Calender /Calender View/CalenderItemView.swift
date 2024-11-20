//
//  TaskItemView.swift
//  project2
//
//  Created by sumaiya on 24/10/2567 BE.
//

import SwiftUI

struct CalenderItemView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var vm: AgendaViewModel
    
    let item: Any
    
    @Binding var itemBinding: Any?
    @Binding var showDeletePopup: Bool
    @Binding var activeSwipedItem: String?
    
    @State private var offset: CGFloat = 0
    @State private var showDelete: Bool = false
    @State private var showingAddPostView = false
    @State private var showAddToDrafts: Bool = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            if showAddToDrafts {
                AddToDraftsButton
            }
            ZStack(alignment: .trailing) {
                // Back delete button
                if showDelete {
                    DeleteButton
                }
                
                // Main content with swipe-to-delete functionality
                HStack(spacing: 10) {
                    VStack(alignment: .center) {
                        Image(systemName: vm.getImageName(for: item))
                            .foregroundStyle(Color.white)
                            .font(.system(size: 30))
                    }
                    .padding(.leading)
                    
                    Rectangle()
                        .frame(width: 1)
                        .foregroundColor(.gray)
                        .padding(.vertical)
                    
                    Text(vm.getTitle(for: item))
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    if let post = item as? Post {
                        HStack {
                            ForEach(post.platforms ?? [], id: \.self) { platform in
                                Image(platform.iconName(for: colorScheme))
                                    .resizable()
                                    .frame(width: 18, height: 18)
                            }
                        }
                        .padding(.trailing)
                        .padding(.top, -15)
                    }
                }
                .frame(width: 350, height: 60, alignment: .leading)
                .background(Color("BabyBlue"))
                .cornerRadius(12)
                .offset(x: offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            // Determine swipe direction
                            if value.translation.width < 0 { // Swiping left
                                offset = value.translation.width
                            } else if value.translation.width > 0 { // Swiping right
                                offset = value.translation.width
                            }
                        }
                        .onEnded { value in
                            withAnimation {
//                                if value.translation.width > 100 { // Swiped left
//                                    offset = 100
//                                    showAddToDrafts = true
//                                    showDelete = false
//                                    activeSwipedItem = getItemID()
//                                }
//                                else
                                if value.translation.width < -100 { // Swiped right
                                    offset = -100
                                    showDelete = true
                                    showAddToDrafts = false
                                    activeSwipedItem = getItemID()
                                }
                                else {
                                    resetState()
                                }
                            }
                        }
                )
                .onTapGesture {
                    showingAddPostView = true
                }
                .fullScreenCover(isPresented: $showingAddPostView) {
                    EditView(post: item as? Post , event: item as? Event )
                }
                .onChange(of: activeSwipedItem) { newValue in
                    if newValue != getItemID() {
                        resetState()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 100, alignment: .leading)
                .padding(.horizontal)
                
            }
            //            .onChange(of: showDeletePopup) { _ in
            //                resetState()
            //            }
        }
    }
    
    // Delete Button View
    private var DeleteButton: some View {
        Button {
            showDeletePopup = true // Show delete confirmation popup
            itemBinding = item
        } label: {
            Label("", systemImage: "trash")
                .font(.system(size: 30))
                .foregroundColor(.white)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: 180)
                .background(Color.red)
                .cornerRadius(12)
        }
        .padding(.trailing, 15)
        .transition(.move(edge: .trailing))
    }
    
    // Add to Drafts Button View
    private var AddToDraftsButton: some View {
        Button {
            //TODO: add To Drafts Action
            print("Add to Drafts Button Pressed")
        } label: {
            Label("", systemImage: "doc.text")
                .font(.system(size: 18))
                .foregroundColor(.white)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: 180)
                .background(Color.green)
                .cornerRadius(12)
        }
        .padding(.leading, 15)
        .transition(.move(edge: .leading))
    }
    
    private func resetState() {
        withAnimation {
            offset = 0
            showDelete = false
        }
    }
    
    // Return a unique identifier for the item
    private func getItemID() -> String {
        if let post = item as? Post {
            return post.postId
        } else if let event = item as? Event {
            return event.eventId
        }
        
        // Fallback for unmatched items
        return UUID().uuidString
    }
}
