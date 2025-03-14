//
//  NoteRowView.swift
//  Notes
//
//  Created by darshana-8393 on 09/03/25.
//

import SwiftUI

struct NoteRowView: View {
    @ObservedObject var selectedAttributes: SelectedAttributes
    @Binding var hoveredNote: Note?
    @ObservedObject var note: Note
    
    var body: some View {
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
                Button(action: {
                    note.starred.toggle()
                }){
                    Image(systemName: note.starred ? "star.fill" : "star")
                        .foregroundColor(note.starred ? Color.yellow : Color.gray)
                }
                .buttonStyle(PlainButtonStyle())
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
}
