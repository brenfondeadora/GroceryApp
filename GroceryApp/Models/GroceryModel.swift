//
//  GroceryModel.swift
//  GroceryApp
//
//  Created by Brenda Saavedra  on 31/05/23.
//

import Foundation
import GroceryAppSharedDTO

class GroceryModel: ObservableObject {
    
    let httpClient = HTTPClient()
    
    func register(username: String, password: String) async throws -> RegisterResponseDTO {
        
        let registerData = [Constants.Endpoints.Login.username: username, Constants.Endpoints.Login.password: password]
        let resource = try Resource(url:Constants.Urls.register, method: .post(JSONEncoder().encode(registerData)), modelType: RegisterResponseDTO.self)
        let registerResponseDTO = try await httpClient.load(resource)
        return registerResponseDTO
    }
    
    func login(username: String, password: String) async throws -> LoginResponseDTO {
        let loginPostData = [Constants.Endpoints.Login.username: username, Constants.Endpoints.Login.password: password]
        
        // resource
        let resource = try Resource(url: Constants.Urls.login, method: .post(JSONEncoder().encode(loginPostData)), modelType: LoginResponseDTO.self)
        
        let loginResponseDTO = try await httpClient.load(resource)
        
        if !loginResponseDTO.error && loginResponseDTO.token != nil && loginResponseDTO.userId != nil {
            // save the token in user defaults
            let defaults = UserDefaults.standard
            defaults.set(loginResponseDTO.token!, forKey: Constants.Defaults.authToken)
            defaults.set(loginResponseDTO.userId!.uuidString, forKey: Constants.Defaults.userId)
        }
        
        return loginResponseDTO
    }
    
    func saveGroceryCategory(_ groceryCategoryRequestDTO: GroceryCategoryRequestDTO) async throws {
        
        let defaults = UserDefaults.standard
        guard let userIdString = defaults.string(forKey: Constants.Defaults.userId),
                let userId = UUID(uuidString: userIdString) else{
            return
        }
        
        let resource = try Resource(url: Constants.Urls.saveGroceryCategory(userId: userId), method: .post(JSONEncoder().encode(groceryCategoryRequestDTO)), modelType: GroceryCategoryResponseDTO.self)
        
        // /api/users/:userId/grocery-categories
        try await httpClient.load(resource)
        // add new grocery to the list
    }
    
}
