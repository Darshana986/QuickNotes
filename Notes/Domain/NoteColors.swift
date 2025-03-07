//
//  NoteColors.swift
//  Notes
//
//  Created by darshana-8393 on 07/03/25.
//

import SwiftUI

enum NoteColor: Int, CaseIterable {
    case blue = 0
    case purple
    case pink
    case yellow
    case white
    case green
    case grey
    
    var name: String {
        get {
            switch self {
            case .blue:
                return "Blue"
            case .purple:
                return "Purple"
            case .pink:
                return "Pink"
            case .yellow:
                return "Yellow"
            case .white:
                return "White"
            case .green:
                return "Green"
            case .grey:
                return "Grey"
            }
        }
    }

    
    var color: Color {
        get {
            switch self {
            case .green:
                return Color(red: 236/255, green: 252/255, blue: 169/255)
            case .purple:
                return Color(red: 202/255, green: 194/255, blue: 251/255)
            case .pink:
                return Color(red: 243/255, green: 213/255, blue: 252/255)
            case .yellow:
                return Color(red: 253/255, green: 241/255, blue: 151/255)
            case .white:
                return Color(red: 255/255, green: 255/255, blue: 255/255)
            case .blue:
                return Color(red: 149/255, green: 207/255, blue: 251/255)
            case .grey:
                return Color(red: 219/255, green: 231/255, blue: 239/255)
            }
        }
    }
}
