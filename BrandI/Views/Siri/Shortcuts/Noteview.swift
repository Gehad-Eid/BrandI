//
//  Noteview.swift
//  Challange1
//
//  Created by sumaiya on 27/10/2567 BE.
//

//import SwiftUI
//import PhotosUI
//import AppIntents

//
//struct NoteView: View {
//    @Environment(\.scenePhase) var scenePhase
//    @ObservedObject private var viewModel = SiriViewModel.shared
//    @State private var isPresented: Bool = false
//    @State private var noteString: String = ""
//    @State private var contenteString: String = ""
//    @State private var selectedImageItem: PhotosPickerItem?
//    @State private var selectedImageData: Data?
//    @State private var tipIsShown = true // Showing the tips
//
//    var body: some View {
//        NavigationStack {
//            SiriTipView(
//                intent: AddNoteIntent(),
//                isVisible: $tipIsShown
//            )
//            VStack {
//                List {
//                    ForEach(viewModel.storedNotes) { note in
//                        Button(action: {
//                            viewModel.selectedNote = note
//                            viewModel.showNoteDetail = true // Activate navigation to NoteDetailView
//                        }) {
//                            VStack(alignment: .leading) {
//                                Text(note.title)
//                                    .font(.headline)
//                                Text(note.content)
//                                    .font(.subheadline)
//                                    .foregroundColor(.gray)
//                                if let imageData = note.image, let image = UIImage(data: imageData) {
//                                    Image(uiImage: image)
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(height: 200)
//                                }
//                            }
//                        }
//                    }
//                    .onDelete(perform: { indexSet in
//                        viewModel.deleteValuesFromUserDefaults(indexSet: indexSet)
//                    })
//                }
//                .navigationTitle("Notes")
//                .toolbar {
//                    ToolbarItem(placement: .topBarTrailing) {
//                        Button(action: { isPresented.toggle() }) {
//                            HStack {
//                                Text("Add Note")
//                                Image(systemName: "plus")
//                            }
//                        }
//                    }
//                    ToolbarItem(placement: .topBarLeading) { EditButton() }
//                }
//                .sheet(isPresented: $isPresented) {
//                    VStack {
//                        TextField("Add your note title...", text: $noteString)
//                            .padding()
//                        TextField("Add your note content...", text: $contenteString)
//                            .padding()
//
//                        PhotosPicker(selection: $selectedImageItem, matching: .images) {
//                            Text("Select an image")
//                                .padding()
//                                .foregroundColor(.blue)
//                        }
//                        .onChange(of: selectedImageItem) { newItem in
//                            Task {
//                                if let newItem = newItem,
//                                   let data = try? await newItem.loadTransferable(type: Data.self) {
//                                    selectedImageData = data
//                                }
//                            }
//                        }
//
//                        Section {
////                            Button("Add") {
////                                let newNote = Note(title: noteString, content: contenteString, image: selectedImageData)
////                                viewModel.writeValuesToUserDefaults(note: newNote)
////                                isPresented.toggle()
////                            }
//                            .frame(maxWidth: .infinity, alignment: .center)
//                        }
//                    }
//                    .padding()
//                }
//                // Bind showNoteDetail for programmatically navigating to NoteDetailView
//                .background(
//                    NavigationLink(
//                        destination: NoteDetailView(note: viewModel.selectedNote ?? viewModel.storedNotes.first!),
//                        isActive: $viewModel.showNoteDetail
//                    ) {
//                        EmptyView()
//                    }
//                )
//                .onAppear {
//                    viewModel.readValuesFromUserDefaults()
//                }
//                .onChange(of: scenePhase) { _ in
//                    viewModel.readValuesFromUserDefaults()
//                }
//                
//                ShortcutsLink()
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
//
//
//
//
//#Preview {
//    ContentView()
//}
//
//
//struct NoteDetailView: View {
//    let note: Post
//    @ObservedObject var viewModel = SiriViewModel.shared
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(note.title)
//                .font(.largeTitle)
//                .padding(.bottom)
//            
//            Text(note.content)
//                .font(.body)
//                .padding(.bottom)
////            
////            if let imageData = note.image, let image = UIImage(data: imageData) {
////                Image(uiImage: image)
////                    .resizable()
////                    .scaledToFit()
////                    .frame(height: 300)
////                    .padding(.bottom)
////            }
//        }
//        .padding()
//        .navigationTitle(note.title)
//    }
//}
//
//
////what I do is
//// Adding a post from the shortcut
//// Open the list of the note from the short cut
//// shortcut is work
////_____________________________________________________________________
//// -- what I need to fix:
////is Opening the note with parameters -- editing the queries
//// -- allowing to get the command from Siri
//// -- Home Screen Widget
//// -- Control center
//
//
//
