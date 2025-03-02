//
//  Folder.swift
//  Notes
//
//  Created by darshana-8393 on 07/02/25.
//

import Cocoa

class Folder: ObservableObject, Identifiable, Equatable, Hashable {
    let id = UUID()
    let folderName: String
    let imageName: String
    var subfolders: [Folder]?
    @Published var notes: [Note] // This will trigger UI updates when changed
    
    init(folderName: String, imageName: String, subfolders: [Folder]? = nil, notes: [Note] = []) {
        self.folderName = folderName
        self.imageName = imageName
        self.subfolders = subfolders
        self.notes = notes
    }
    
    static func == (lhs: Folder, rhs: Folder) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func getDefaultFolders() -> [Folder] {
        var defaultFolders: [Folder] = []
        if let allFolder = defaultFoldersDict[.all] {
            defaultFolders.append(allFolder)
        }
        if let personalFolder = defaultFoldersDict[.personal] {
            defaultFolders.append(personalFolder)
        }
        if let workFolder = defaultFoldersDict[.work] {
            defaultFolders.append(workFolder)
        }
        if let educationFolder = defaultFoldersDict[.education] {
            defaultFolders.append(educationFolder)
        }
        if let archiveFolder = defaultFoldersDict[.archive] {
            defaultFolders.append(archiveFolder)
        }
        if let trashFolder = defaultFoldersDict[.trash] {
            defaultFolders.append(trashFolder)
        }
        return defaultFolders
    }
}

enum ParentFolderType {
    case all
    case personal
    case work
    case education
    case archive
    case trash
}

let defaultFoldersDict: [ParentFolderType: Folder] = [ .all: Folder(folderName: "All Notes", imageName: "tray.full", notes: sampleAllNotes),
                                                       
    .personal: Folder(folderName: "Personal", imageName: "person.crop.circle", subfolders: [
        Folder(folderName: "Journal", imageName: "book.closed"),
        Folder(folderName: "Ideas", imageName: "lightbulb"),
        Folder(folderName: "Goals & Resolutions", imageName: "target"),
        Folder(folderName: "Reading Notes", imageName: "books.vertical"),
    ], notes: samplePersonalNote),
                                                       
    .work: Folder(folderName: "Work", imageName: "briefcase", subfolders: [
        Folder(folderName: "Meetings & Minutes", imageName: "calendar.badge.clock"),
        Folder(folderName: "Tasks & To-Dos", imageName: "checklist"),
        Folder(folderName: "Project Notes", imageName: "pin"),
        Folder(folderName: "Reports & Research", imageName: "chart.bar"),
    ], notes: sampleWorkNote),
                                                       
    .education: Folder(folderName: "Education & Learning", imageName: "graduationcap", subfolders: [
        Folder(folderName: "Course Notes", imageName: "book"),
        Folder(folderName: "Study Plans", imageName: "medal"),
        Folder(folderName: "Research Notes", imageName: "brain.head.profile"),
    ], notes: sampleEducationNote),
                                                       
    .archive: Folder(folderName: "Archive",imageName: "archivebox", subfolders: [
        Folder(folderName: "Old Notes", imageName: "tray.full"),
        Folder(folderName: "Reference Material", imageName: "scroll"),
    ]),
                                                       
    .trash:  Folder(folderName: "Trash", imageName: "trash.fill")
]

