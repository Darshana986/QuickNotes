//
//  NoteEditorView.swift
//  Notes
//
//  Created by darshana-8393 on 28/02/25.
//

import SwiftUI

struct NoteEditorView: View {
    @ObservedObject var note: Note
    
    var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer()
                    ColorPickerButton(selectedColor: Binding(
                        get: { note.color },
                        set: { note.color = $0 }
                    ))
                        .background(Color.clear)
                }
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
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(10)
            .background(note.color.color)
        
    }
}

#Preview {
    NavigationStack {
        NoteEditorView(note: Note(title: "Sample Title", content: "Edit this content..."))
    }
}
