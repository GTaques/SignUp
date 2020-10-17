//
//  Customer.swift
//  UserSignUp
//
//  Created by APPLE DEVELOPER ACADEMY on 16/10/20.
//

import Foundation

enum Genres: String, CaseIterable {
    case feminine = "Feminino"
    case masculino = "Masculino"
    case outro = "Outro"
}

struct Customer {
    
    let id = UUID()
    var name: String!
    var phone: String!
    var cpf: String!
    var bornDate: Date!
    var gender: String! 
    var createdAt = Date()
    
    
}
