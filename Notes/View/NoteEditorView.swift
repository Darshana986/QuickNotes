//
//  NoteEditorView.swift
//  Notes
//
//  Created by darshana-8393 on 28/02/25.
//

import SwiftUI

struct NoteEditorView: View {
    @Binding var note: Note?
    
    var body: some View {
        if note != nil {
            VStack(alignment: .leading, spacing: 0) {
                TextField("Title", text: Binding(
                    get: { note?.title ?? "" },
                    set: { note?.title = $0 }
                ))
                    .font(.title2)
                    .bold()
                    .textFieldStyle(.plain)
                    .padding(.horizontal, 2)
                    .padding(.vertical, 10)
                
                TextEditor(text: Binding(
                    get: { note?.content ?? "" },
                    set: { note?.content = $0 }
                ))
                    .font(.body)
                    .lineSpacing(2)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .scrollIndicators(.never)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(10)
            .background(Color.white)
        } else {
            Text("Empty")
                .font(.system(size: 15))
                .foregroundStyle(.tertiary)
        }
        
    }
}

#Preview {
    NavigationStack {
        NoteEditorView(note: .constant(Note(title: "Sample Title", content: "Edit this content...")))
    }
}
