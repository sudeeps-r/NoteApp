//
//  CreateNote.swift
//  NoteApp
//
//  Created by Sudeep Sathi Ramachandran on 22/4/21.
//

import SwiftUI

struct CreateNote: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel : NoteViewModel
    @Environment(\.managedObjectContext) private var managedObjectContext
    @State var noteTitle = "New Note"
    @State private var message: Message? = nil

    var body: some View {
        VStack {
            TextField("Title", text: $viewModel.title)
                .padding()
                .border(Color.gray)
           
            TextEditor( text: $viewModel.details)
                .frame(maxHeight: .infinity)
                .border(Color.gray)
          
         
            Button("Save") {
                if(viewModel.isEmpty()){
                    self.message = Message(text: "Please add your Note")
                }else{
                    viewModel.saveNote(context:managedObjectContext)
                    exit()
                }
            }
            Spacer(minLength: 0)
          
        } .alert(item: $message) { message in
            Alert(
                title: Text(message.text),
                dismissButton: .cancel()
            )
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(viewModel.isNew() ? "CreateNote" :"EditNote", displayMode:.inline)
        .navigationBarItems(leading:
                                Button(action: {
                                    exit()
                                }){
                                    Image(systemName: "arrow.left")
                                }
            
        )
        
    }

    func exit(){
        presentationMode.wrappedValue.dismiss()
    }
}

struct CreateNote_Previews: PreviewProvider {
    
    static var previews: some View {
        CreateNote(viewModel: NoteViewModel())
    }
}
