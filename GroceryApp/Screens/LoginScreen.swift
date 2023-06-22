//
//  LoginScreen.swift
//  GroceryApp
//
//  Created by Brenda Saavedra  on 31/05/23.
//

import SwiftUI

struct LoginScreen: View {
    
    @EnvironmentObject private var model: GroceryModel
    @EnvironmentObject private var appState: AppState
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && (password.count >= 6 && password.count <= 10)
    }
    
    private func login() async {
        do {
            let loginResponseDTO = try await model.login(username: username, password: password)
            if loginResponseDTO.error {
                errorMessage = loginResponseDTO.reason ?? ""
            } else {
                appState.routes.append(.addGroceryCategory)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    var body: some View {
        Form {
            TextField("Username", text: $username)
                .textCase(.lowercase)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
            
            HStack {
                Button("Login") {
                    Task {
                        await login()
                    }
                }.buttonStyle(.borderless)
                    .disabled(!isFormValid)
            }
            
            Text(errorMessage)
            
        }.navigationTitle("Login")
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginScreen()
                .environmentObject(GroceryModel())
                .environmentObject(AppState())
        }
    }
}
