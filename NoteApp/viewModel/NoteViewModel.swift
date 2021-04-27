//
//  NoteViewModel.swift
//  NoteApp
//
//  Created by Sudeep Sathi Ramachandran on 23/4/21.
//

import SwiftUI
import CoreData

class NoteViewModel : ObservableObject {
    @Published var title = ""
    @Published var details = ""
    @Published var showNewScreen: Bool = false
    @Published var editNote : Note!
    
    func saveNote(context: NSManagedObjectContext){
        if(editNote==nil){
            let note = Note(context: context)
            note.details = details
            note.title = title
            do {
                try context.save()
            } catch  {
                print(error.localizedDescription)
            }
        }else{
            editNote.title = title
            editNote.details = details
            try! context.save()
            editNote = nil
        }
       
    }
    
    func deleteNote(context: NSManagedObjectContext,data: Note){
        context.delete(data)
        try! context.save()
    }
    
    func isNew()-> Bool {
        return editNote==nil
    }
    
    func addNote(){
        editNote = nil
        title = ""
        details = ""
        showNewScreen.toggle()
    }
    func editNote(data: Note){
        editNote = data
        title = data.title!
        details = data.details!
        showNewScreen.toggle()
    }
    
    func isEmpty()-> Bool {
        return title.isEmpty || details.isEmpty
    }
}
