//
//  GroceryModel.swift
//  GroceryApp
//
//  Created by Brenda Saavedra  on 31/05/23.
//

import Foundation
import GroceryAppSharedDTO

class GroceryModel: ObservableObject {
    
    @Published var groceryCategories: [GroceryCategoryResponseDTO] = []
    
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
    
    func populateGroceryCategories() async throws {
        guard let userId = UserDefaults.standard.userId else{
            return
        }
        
        let resource = try Resource(url: Constants.Urls.groceryCategoriesBy(userId: userId), modelType: [GroceryCategoryResponseDTO].self)
        
        groceryCategories = try await httpClient.load(resource)
    }
    
    func saveGroceryCategory(_ groceryCategoryRequestDTO: GroceryCategoryRequestDTO) async throws {
        
        guard let userId = UserDefaults.standard.userId else{
            return
        }
        
        let resource = try Resource(url: Constants.Urls.saveGroceryCategory(userId: userId), method: .post(JSONEncoder().encode(groceryCategoryRequestDTO)), modelType: GroceryCategoryResponseDTO.self)
        
        // /api/users/:userId/grocery-categories
        let groceryCategory = try await httpClient.load(resource)
        // add new grocery to the list
        groceryCategories.append(groceryCategory)
    }
    
}
