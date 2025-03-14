//
//  ContentView.swift
//  Notes
//
//  Created by darshana-8393 on 07/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var foldersList = FolderList()
    @StateObject private var selectedAttributes = SelectedAttributes()
    @State var showAllColumns: Bool = true
    @State private var showDeleteAlert = false
    
    var body: some View {
        Group {
            if showAllColumns {
                NavigationSplitView(sidebar: {
                    SidebarView(folders: $foldersList.folders, selectedFolder: $selectedAttributes.selectedFolder, selectedNote: $selectedAttributes.selectedNote)
                        .frame(minWidth: 200)
                }, content: {
                    if selectedAttributes.selectedFolder == nil || selectedAttributes.selectedFolder?.notes.isEmpty == true {
                        Text("No Notes")
                            .font(.system(size: 15))
                            .foregroundStyle(.tertiary)
                    } else {
                        NotesListView(selectedAttributes: selectedAttributes, onDeleteNote: { note in
                            deleteNote(note: note)
                        })
                        .frame(minWidth: 200)
                    }
                    
                }, detail: {
                    DetailView(selectedAttributes: selectedAttributes, showAllColumns: $showAllColumns)
                })
            } else {
                DetailView(selectedAttributes: selectedAttributes, showAllColumns: $showAllColumns)
            }
        }
        .navigationTitle(selectedAttributes.selectedFolder?.folderName ?? "Notes")
        .toolbar {
            ToolbarItemGroup(placement: .automatic) {
                Button(action: addNote) {
                    Image(systemName: "square.and.pencil")
                }
                if selectedAttributes.selectedNote != nil {
                    Button(action: { showDeleteAlert = true }) {
                        Image(systemName: "trash")
                    }
                }
            }
        }
        .toolbarColorScheme(.light, for: .automatic)
        .alert("Are you sure you want to delete this note?", isPresented: $showDeleteAlert, actions: {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive, action: deleteNote)
        })
    }
    
    func addNote() {
        let newNote = Note(title: "New Note", content: "This is a new note")
        let folder = selectedAttributes.selectedFolder
        folder?.notes.insert(newNote, at: 0)
        selectedAttributes.selectedFolder = folder
    }
    
    func deleteNote() {
        guard selectedAttributes.selectedFolder != nil, selectedAttributes.selectedFolder?.notes.count ?? 0 > 0, selectedAttributes.selectedNote != nil else {return}
        deleteNote(note: selectedAttributes.selectedNote!)
    }
    
    func insertInTrashFolder(note: Note) {
        guard let trashFolder = foldersList.getFolder(folderType: .trash) else {return}
        trashFolder.notes.append(note)
    }
    
    private func deleteNote(note: Note) {
        if let index = selectedAttributes.selectedFolder!.notes.firstIndex(where: {
            $0.id == note.id
        }) {
            let noteToDelete = selectedAttributes.selectedFolder!.notes[index]
            insertInTrashFolder(note: noteToDelete)
            
            selectedAttributes.selectedFolder!.notes.remove(at: index)
            guard selectedAttributes.selectedNote?.id == note.id, index >= 0 else { return}
            if index >= selectedAttributes.selectedFolder!.notes.count {
                selectedAttributes.selectedNote = selectedAttributes.selectedFolder!.notes.last
            } else {
                selectedAttributes.selectedNote = selectedAttributes.selectedFolder?.notes[index]
            }
        }
    }
}

#Preview {
    ContentView()
}


struct DetailView: View {
    @ObservedObject var selectedAttributes: SelectedAttributes
    @Binding var showAllColumns: Bool
    
    var body: some View {
        if let note = selectedAttributes.selectedNote {
            NoteEditorView(note: note, showAllColumns: $showAllColumns)
                .frame(minWidth: 200, maxWidth: .infinity, maxHeight: .infinity)
        } else {
            Text("Empty")
                .font(.system(size: 15))
                .foregroundStyle(.tertiary)
        }
    }
}
