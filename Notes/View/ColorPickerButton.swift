//
//  ColorPickerButton.swift
//  Notes
//
//  Created by darshana-8393 on 07/03/25.
//

import SwiftUI

struct ColorPickerButton: View {
    @Binding var selectedColor: NoteColor
    var size: CGFloat = 15

    var body: some View {
        Menu {
            ForEach(NoteColor.allCases, id: \.rawValue) { noteColor in
                Button(action: {
                    selectedColor = noteColor
                }) {
                    Text(noteColor.name)
                }
            }
        } label: {
            Circle()
                .fill(selectedColor.darkColor)
                .frame(width: size, height: size)
                .overlay(Circle().stroke(Color.black.opacity(0.4), lineWidth: 1))
        }
        .buttonStyle(PlainButtonStyle())
    }
}

