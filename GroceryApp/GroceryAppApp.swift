//
//  GroceryAppApp.swift
//  GroceryApp
//
//  Created by Brenda Saavedra  on 18/05/23.
//

import SwiftUI

@main
struct GroceryAppApp: App {
    
    @StateObject private var model = GroceryModel()
    
    var body: some Scene {
        WindowGroup {
            RegistrationScreen()
                .environmentObject(model)
        }
    }
}
