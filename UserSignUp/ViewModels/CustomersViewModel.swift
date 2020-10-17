//
//  CustomersViewModel.swift
//  UserSignUp
//
//  Created by APPLE DEVELOPER ACADEMY on 17/10/20.
//

import Foundation
import SwiftUI
import CoreData

class CustomersViewModel: ObservableObject {
    
    @Published var customers: [NSManagedObject] = []
    @Published var customer: Customer = Customer()
    
    
}
