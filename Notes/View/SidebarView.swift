//
//  SidebarView.swift
//  Notes
//
//  Created by darshana-8393 on 07/02/25.
//

import SwiftUI

struct SidebarView: View {
    @Binding var folders: [Folder]
    @Binding var selectedFolder: Folder?
    @Binding var selectedNote: Note?
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.1) // Base color with transparency
                .background(.ultraThinMaterial) // Frosted glass effect
            List{
                ForEach(folders) { folder in
                    FolderRow(folder: folder, onSelect: {
                        selectedNote = nil
                    }, selectedFolder: $selectedFolder)
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .padding(.top)
            .frame(minWidth: 200, idealWidth: 250, maxWidth: 300)
            .navigationTitle("Folders")
        }
    }
}


struct FolderRow: View {
    let folder: Folder
    var onSelect: ()->Void
    @Binding var selectedFolder: Folder?
    
    var isSelected: Bool {
        selectedFolder == folder
    }
    
    var body: some View {
        Group {
            if folder.subfolders?.isEmpty == false {
                DisclosureGroup(content: {
                    ForEach(folder.subfolders ?? [], id: \.id) { subfolder in
                        FolderRow(folder: subfolder, onSelect: onSelect, selectedFolder: $selectedFolder)
                    }
                }, label: {
                    FolderRowContent(folder: folder, isSelected: isSelected, onTap: {
                        selectedFolder = folder
                        onSelect()
                    })
                })
                
            } else {
                FolderRowContent(folder: folder, isSelected: isSelected, onTap: {
                    selectedFolder = folder
                    onSelect()
                })
            }
        }
        
    }
}


struct FolderRowContent: View {
    let folder: Folder
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Label(folder.folderName, systemImage: folder.imageName)
            .font(.system(size: 13, weight: .regular))
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity, minHeight: 25, alignment: .leading)
            .contentShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
            .background(isSelected ? Color.blue.opacity(0.2) : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
            .animation(.easeInOut, value: isSelected)
            .onTapGesture(perform: onTap)
    }
}
