//
//  SelectedAttributesModel.swift
//  Notes
//
//  Created by darshana-8393 on 08/03/25.
//

import SwiftUI

class SelectedAttributes: ObservableObject {
    @Published var selectedFolder: Folder? = defaultFoldersDict[.all]
    @Published var selectedNote: Note? = nil
    
    init(selectedFolder: Folder? = defaultFoldersDict[.all], selectedNote: Note? = nil) {
        self.selectedFolder = selectedFolder
        self.selectedNote = selectedNote
    }
}
