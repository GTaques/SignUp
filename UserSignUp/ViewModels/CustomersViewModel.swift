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
    let context = DataStore.shared.persistentContainer.viewContext
    
    init() {
        readData()
    }
    
    func readData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CustomerEntity")
        do {
            let results = try context.fetch(request)
            self.customers = results as! [NSManagedObject]
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func writeData() {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "CustomerEntity", into: context)
        entity.setValuesForKeys([
            "name": customer.name as String,
            "phone": customer.phone as String,
            "cpf": customer.cpf as String,
            "bornDate": customer.bornDate as Date,
            "genre": customer.gender as Genres,
            "createdAt": customer.createdAt as Date
        ])
        
        do {
            try context.save()
            self.customers.append(entity)
            
            customer = Customer()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteData(indexSet: IndexSet) {
        for index in indexSet {
            do {
                let obj = customers[index]
                context.delete(obj)
                try context.save()
                
                if let index = customers.firstIndex(of: obj) {
                    customers.remove(at: index)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func updateData() {
        
    }
    
    func getValue(obj: NSManagedObject) -> Customer {
        let name = obj.value(forKey: "name")
        let phone = obj.value(forKey: "phone")
        let cpf = obj.value(forKey: "cpf")
        let bordDate = obj.value(forKey: "bornDate")
        let genre = obj.value(forKey: "genre")
        let createdAt = obj.value(forKey: "createdAt")
        
        return Customer(name: name as? String, phone: phone as? String, cpf: cpf as? String, bornDate: bordDate as? Date, gender: genre as? Genres, createdAt: createdAt as! Date)
    }
    
}
