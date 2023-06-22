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
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appState.routes) {
                RegistrationScreen()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                            case .register:
                                RegistrationScreen()
                            case .login:
                                LoginScreen()
                            case .groceryCategoryList:
                                GroceryCategoryListScreen()
                        }
                    }
            }
            .environmentObject(model)
            .environmentObject(appState)
        }
    }
}
