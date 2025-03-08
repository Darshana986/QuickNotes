//
//  NoteEditorView.swift
//  Notes
//
//  Created by darshana-8393 on 28/02/25.
//

import SwiftUI

struct NoteEditorView: View {
    @ObservedObject var note: Note
    @Binding var showAllColumns: Bool
    
    var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Button(action: {
                        showAllColumns.toggle()
                    }) {
                        Image(systemName: showAllColumns ? "arrow.up.left.and.arrow.down.right" : "arrow.down.right.and.arrow.up.left" )
                    }
                    .buttonStyle(PlainButtonStyle())
                    Spacer()
                    ColorPickerButton(selectedColor: Binding(
                        get: { note.color },
                        set: { note.color = $0 }
                    ))
                        .background(Color.clear)
                }
                Group {
                    TextField("Title", text: Binding(
                        get: { note.title},
                        set: { note.title = $0 }
                    ))
                    .font(.title2)
                    .bold()
                    .textFieldStyle(.plain)
                    .padding(.horizontal, 2)
                    .padding(.vertical, 10)
                    
                    TextEditor(text: Binding(
                        get: { note.content },
                        set: { note.content = $0 }
                    ))
                    .font(.body)
                    .lineSpacing(2)
                    .foregroundStyle(.secondary)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .scrollIndicators(.never)
                }
                .padding(.horizontal, 25)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(10)
            .background(note.color.color)
        
    }
}

#Preview {
    NavigationStack {
        NoteEditorView(note: Note(title: "Sample Title", content: "Edit this content..."), showAllColumns: Binding(get: {true}, set: {_ in }))
    }
}
