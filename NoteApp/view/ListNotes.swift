//
//  ContentView.swift
//  NoteApp
//
//  Created by Sudeep Sathi Ramachandran on 22/4/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(entity: Note.entity(), sortDescriptors: []) var results : FetchedResults<Note>
    @StateObject var viewModel = NoteViewModel()
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        NavigationView {
           
            VStack{

                NavigationLink(destination:  CreateNote(viewModel: viewModel), isActive: $viewModel.showNewScreen) {}
               
                if(results.isEmpty){
                    Button("ListNoteEmptyMsg") {
                        viewModel.addNote()
                    }
                    .frame(maxHeight: .infinity)
                }
                List{
                    ForEach(results){ task in
                        VStack(alignment: .leading, spacing: 5, content: {
                            Button(task.title ?? "") {
                                viewModel.editNote(data: task)
                            }.foregroundColor(Color.black)
                          
                        })
                    }.onDelete(perform: deleteItem)
                }.listStyle(PlainListStyle())
                 .navigationBarTitle("ListNoteNavTitle", displayMode: .inline)
                 .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                                        Button(action: {
                                            viewModel.addNote()
                                        }){
                                            Image (systemName: "plus")
                                        }
                                    }
                                }
                
            }
            
        }
      
    }
    
    
    func deleteItem(at offsets: IndexSet){
        for index in offsets {
            let note = results[index]
                viewModel.deleteNote(context: context, data: note)
            }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                ContentView()
                ContentView()
                ContentView()
            }
        }
}

}
