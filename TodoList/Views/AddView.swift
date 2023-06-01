//
//  AddView.swift
//  TodoList
//
//  Created by Kamil Wójcicki on 17/05/2023.
//

import SwiftUI

struct AddView: View {
    
    @State private var textFieldText: String = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var listViewModel: ListViewModel
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type sth here...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    
                Button {
                    saveButtonPressed()
                } label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }

            }
            .padding(14)
        }
        .navigationTitle("Add an Item 🖊️")
        .alert(alertTitle, isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
//        .navigationBarBackButtonHidden()
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//                    dismiss.callAsFunction()
//                } label: {
//                    Text("Back")
//                }
//            }
//        }
    }
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            listViewModel.addItem(title: textFieldText)
            dismiss.callAsFunction()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
            alertTitle = "Your new todo item must be at least 3 characters long!! 😵‍💫"
            showAlert.toggle()
            return false
        }
        return true
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddView()
        }
        .environmentObject(ListViewModel())
    }
}
