//
//  LoginResponseDTO.swift
//  GroceryApp
//
//  Created by Brenda Saavedra  on 31/05/23.
//

import Foundation

struct LoginResponseDTO: Codable {
    let error: Bool
    var reason: String? = nil
    var token: String? = nil
    var userId: UUID? = nil
}
