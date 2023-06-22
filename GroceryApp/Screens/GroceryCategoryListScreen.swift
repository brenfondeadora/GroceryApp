//
//  GroceryCategoryListScreen.swift
//  GroceryApp
//
//  Created by Brenda Saavedra Cantu on 22/06/23.
//

import SwiftUI

struct GroceryCategoryListScreen: View {
    
    @EnvironmentObject private var model: GroceryModel
    
    private func fetchGroceryCategories() async {
        do {
            try await model.populateGroceryCategories()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        List(model.groceryCategories) { groceryCategory in
            HStack {
                Circle()
                    .fill(Color.fromHex(groceryCategory.colorCode))
                    .frame(width: 25, height: 25)
                Text(groceryCategory.title)
            }
        }.task {
            await fetchGroceryCategories()
        }
        .navigationTitle("Categories")
    }
}

struct GroceryCategoryListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GroceryCategoryListScreen()
                .environmentObject(GroceryModel())
        }
    }
}
