//
//  Note.swift
//  Notes
//
//  Created by darshana-8393 on 07/02/25.
//

import Foundation

class Note: Identifiable, ObservableObject, Equatable, Hashable {
    let id = UUID()
    var title: String
    var content: String
    var date: Date
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
        self.date = Date()
    }
    
    static func == (lhs: Note, rhs: Note) -> Bool {
        lhs.id == rhs.id
    }
   
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func formattedDate(date: Date) -> String {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        let dateYear = calendar.component(.year, from: date)
        
        let formatter = DateFormatter()
        
        if dateYear == currentYear {
            // If the date is from the current year, format as "Day, Month Date"
            formatter.dateFormat = "EE, MMM d" // Example: "Saturday, Mar 2"
        } else {
            // If the date is from a different year, format as "Date Month Year"
            formatter.dateFormat = "d MMM yyyy" // Example: "2 Mar 2023"
        }
        
        return formatter.string(from: date)
    }
}


let sampleAllNotes: [Note] = [Note(title: "Getting Started: Capture Your First Note",
                                   content: "Welcome to Notes! 🎉 Here’s how to get started:\n\n- Tap the **+ button** to create a new note ✏️\n- Start typing—your changes are saved automatically 💾\n- Organize notes into folders like Personal, Work, and Education 📂\n- Use **Quick Notes** for spontaneous thoughts, reminders, or things you need to jot down fast ⚡️\n- Search for notes anytime using the 🔍 search bar\n\nStart writing your first note now!")]

let samplePersonalNote: [Note] = [Note(title: "Personal Notes: Capture Your Life",
                                       content: "Use this folder for personal thoughts, journals, and daily reflections. You can store: \n- Your journal entries 📝\n- Daily affirmations 💭\n- Dream logs 🌙\n- Shopping lists 🛒\n- Personal to-do lists ✅\n\nKeep everything important to you in one place!")]

let sampleWorkNote: [Note] = [Note(title: "Work Notes: Stay Organized",
                                   content: "Keep track of your work-related notes here. This includes:\n- Meeting minutes 🗓\n- Task lists 🏗\n- Client feedback 💼\n- Project documentation 📂\n- Brainstorming ideas 💡\n\nUse this folder to keep your professional life structured.")]

let sampleEducationNote: [Note] = [Note(title: "Education Notes: Learn & Grow",
                                  content: "Use this folder to organize your learning materials. You can store:\n- Lecture notes 📖\n- Study guides 🏆\n- Research summaries 🔬\n- Exam preparation plans 🎯\n- Book summaries 📚\n\nGreat for students, self-learners, and lifelong learners!")]



