//
//  AddGroceryCategoryScreen.swift
//  GroceryApp
//
//  Created by Brenda Saavedra Cantu on 16/06/23.
//

import SwiftUI

struct AddGroceryCategoryScreen: View {
    
    @State private var title: String = ""
    @State private var colorCode: String = "#58D68D"
    
    @Environment(\.dismiss) private var dismiss
    
    private func saveGroceryCategory() async {
        
    }
    
    private var isFormValid: Bool {
        !title.isEmptyOrWhiteSpace
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            ColorSelector(colorCode: $colorCode)
        }.navigationTitle("New Category")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task {
                            await  saveGroceryCategory()
                        }
                    }.disabled(!isFormValid)
                }
            }
    }
}

struct AddGroceryCategoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddGroceryCategoryScreen()
        }
    }
}
