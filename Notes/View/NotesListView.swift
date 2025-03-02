//
//  NotesListView.swift
//  Notes
//
//  Created by darshana-8393 on 07/02/25.
//

import SwiftUI

struct NotesListView: View {
    @Binding var selectedFolder: Folder?
    @Binding var selectedNote: Note?
    @State private var hoveredNote: Note?
    var body: some View {
        List(selectedFolder?.notes ?? [], selection: $selectedNote) { note in
            VStack(alignment: .leading, spacing: 4, content: {
                Text(note.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(note.content)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .truncationMode(.tail)
                
                HStack {
                    Text(note.formattedDate(date: note.date))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 7)
            })
            .listRowSeparator(.visible)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical,10)
            .padding(.horizontal, 7)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(selectedNote == note ? Color.blue.opacity(0.2) : hoveredNote == note ? Color.gray.opacity(0.2) : Color.clear)
            )
            .contentShape(Rectangle())
            .onTapGesture {
                selectedNote = note
            }
            .onHover { isHovering in
                hoveredNote = isHovering ? note : nil
            }
        }
        .listStyle(.inset)
    }
}

#Preview {
    NotesListView(selectedFolder: Binding.constant(defaultFoldersDict[.all]!), selectedNote: Binding.constant(nil))
}
