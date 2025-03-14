//
//  NotesListView.swift
//  Notes
//
//  Created by darshana-8393 on 07/02/25.
//

import SwiftUI

struct NotesListView: View {
    @ObservedObject var selectedAttributes: SelectedAttributes
    @State private var hoveredNote: Note?
    @FocusState var isFocused: Bool
    let onDeleteNote: (Note)->Void?
    var selectedIndex: Int {
        if let note = selectedAttributes.selectedNote {
            return selectedAttributes.selectedFolder?.notes.firstIndex(of: note) ?? -1
        } else {
            return -1
        }
    }
    
    
    var body: some View {
        List(selection: $selectedAttributes.selectedNote) {
            ForEach(selectedAttributes.selectedFolder?.notes ?? [], id: \.id, content: {
                note in
                    NoteRowView(selectedAttributes: selectedAttributes, hoveredNote: $hoveredNote, note: note)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            onDeleteNote(note)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            })
            .focusable()
            .focused($isFocused)
            .focusEffectDisabled()
        }
        .listStyle(.inset)
        .onKeyPress(action: {keyPress in
            switch keyPress.key {
            case .downArrow:
                let newSelectedIndex = selectedIndex + 1
                guard let note = getNote(newSelectedIndex) else { return .ignored }
                DispatchQueue.main.async {
                    selectedAttributes.selectedNote = note
                }
            case .upArrow:
                let newSelectedIndex = selectedIndex - 1
                guard let note = getNote(newSelectedIndex) else { return .ignored }
                DispatchQueue.main.async {
                    selectedAttributes.selectedNote = note
                }
            default:
                return .ignored
            }
            return .handled
        })
    }
    
    private func getNote(_ index: Int) -> Note? {
        guard let notes = selectedAttributes.selectedFolder?.notes, !notes.isEmpty else { return nil }
        guard index >= 0 , index < notes.count else { return nil }
        return notes[index]
    }
  
}

#Preview {
    NotesListView(selectedAttributes: SelectedAttributes(), onDeleteNote: {_ in})
}
