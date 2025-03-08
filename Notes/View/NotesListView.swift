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
    var body: some View {
        List(selectedAttributes.selectedFolder?.notes ?? [], selection: $selectedAttributes.selectedNote) { note in
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
                    Spacer()
                    ColorPickerButton(selectedColor: Binding(
                        get: { note.color },
                        set: { note.color = $0 }
                    ), size: 12)
                    .background(Color.clear)
                }
                .padding(.top, 7)
            })
            .listRowSeparator(.visible)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical,10)
            .padding(.horizontal, 7)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(selectedAttributes.selectedNote == note ? Color.blue.opacity(0.2) : hoveredNote == note ? Color.gray.opacity(0.2) : Color.clear)
            )
            .contentShape(Rectangle())
            .onTapGesture {
                selectedAttributes.selectedNote = note
            }
            .onHover { isHovering in
                hoveredNote = isHovering ? note : nil
            }
        }
        .listStyle(.inset)
    }
}

#Preview {
    NotesListView(selectedAttributes: SelectedAttributes())
}
