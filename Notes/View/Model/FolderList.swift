//
//  FolderList.swift
//  Notes
//
//  Created by darshana-8393 on 28/02/25.
//

import SwiftUI

class FolderList: ObservableObject {
    @Published var folders: [Folder] = Folder.getDefaultFolders()
    @Published var selectedFolder: Folder? = defaultFoldersDict[.all]
    @Published var selectedNote: Note? = nil
    
    func getFolder(folderType: ParentFolderType) -> Folder? {
        return defaultFoldersDict[folderType]
    }
}
