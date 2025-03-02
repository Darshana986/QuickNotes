//
//  ContentView.swift
//  Notes
//
//  Created by darshana-8393 on 07/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var foldersList = FolderList()
    @State private var showDeleteAlert = false
    
    var body: some View {
        NavigationSplitView(sidebar: {
            SidebarView(folders: $foldersList.folders, selectedFolder: $foldersList.selectedFolder, selectedNote: $foldersList.selectedNote)
                .frame(minWidth: 200)
        }, content: {
            if foldersList.selectedFolder == nil || foldersList.selectedFolder?.notes.isEmpty == true {
                    Text("No Notes")
                        .font(.system(size: 15))
                        .foregroundStyle(.tertiary)
                } else {
                    NotesListView(selectedFolder: $foldersList.selectedFolder, selectedNote: $foldersList.selectedNote)
                        .frame(minWidth: 200)
                }
            
        }, detail: {
            NoteEditorView(note: $foldersList.selectedNote)
                .frame(minWidth: 200, maxWidth: .infinity, maxHeight: .infinity)
        })
        .navigationTitle(foldersList.selectedFolder?.folderName ?? "Notes")
        .toolbar {
            ToolbarItemGroup(placement: .automatic) {
                Button(action: addNote) {
                    Image(systemName: "square.and.pencil")
                }
                if foldersList.selectedNote != nil {
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
        foldersList.selectedFolder?.notes.insert(newNote, at: 0)
        foldersList.selectedNote = newNote
    }
    
    func deleteNote() {
        guard foldersList.selectedFolder != nil, foldersList.selectedFolder?.notes.count ?? 0 > 0, foldersList.selectedNote != nil else {return}
        if let index = foldersList.selectedFolder!.notes.firstIndex(where: {
            $0.id == foldersList.selectedNote!.id
        }) {
            let noteToDelete = foldersList.selectedFolder!.notes[index]
            insertInTrashFolder(note: noteToDelete)
            
            foldersList.selectedFolder!.notes.remove(at: index)
            guard index >= 0 else { return}
            if index >= foldersList.selectedFolder!.notes.count {
                foldersList.selectedNote = foldersList.selectedFolder!.notes.last
            } else {
                foldersList.selectedNote = foldersList.selectedFolder?.notes[index]
            }
        }
    }
    
    func insertInTrashFolder(note: Note) {
        guard let trashFolder = foldersList.getFolder(folderType: .trash) else {return}
        trashFolder.notes.append(note)
    }
}

#Preview {
    ContentView()
}
