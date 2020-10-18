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
    @Published var customer: Customer = Customer(name: "", phone: "", cpf: "", bornDate: Date(), gender: Genres.feminine.rawValue, createdAt: Date())
    @Published var selectedCustomer = NSManagedObject()
    @Published var statusMessage: String = ""
    @Published var showingCustomerForm: Bool = false
    @Published var showingToast: Bool = false
    @Published var toastColor: Color = Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
    @Published var isUpdate: Bool = false
    let context: NSManagedObjectContext
    let dataStore: CoreDataStack
    
   public init(managedObjectContext: NSManagedObjectContext = CoreDataStack().persistentContainer.viewContext, dataStore: CoreDataStack) {
        self.context = managedObjectContext
        self.dataStore = dataStore
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
            "id": customer.id as UUID,
            "name": customer.name as String,
            "phone": customer.phone as String,
            "cpf": customer.cpf as String,
            "bornDate": customer.bornDate as Date,
            "genre": customer.gender as String,
            "createdAt": customer.createdAt as Date
        ])
        
        do {
            try context.save()
            statusMessage = "Criado com sucesso!"
            self.customers.append(entity)
            customer = Customer(name: "", phone: "", cpf: "", bornDate: Date(), gender: Genres.feminine.rawValue, createdAt: Date())
            toggleToast()
            
        } catch {
            statusMessage = "Erro ao salvar!"
            print(error.localizedDescription)
            toggleToast()
        }
        
        showingCustomerForm.toggle()
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
        let index = customers.firstIndex(of: selectedCustomer)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CustomerEntity")
        
        do {
            let results = try context.fetch(request) as! [NSManagedObject]
            let obj = results.first { (obj) -> Bool in
                if obj == selectedCustomer { return true }
                else { return false }
            }
            obj?.setValuesForKeys([
                "name": customer.name as String,
                "phone": customer.phone as String,
                "cpf": customer.cpf as String,
                "bornDate": customer.bornDate as Date,
                "genre": customer.gender as String,
                "createdAt": customer.createdAt as Date
            ])
            try context.save()
            
            //Success
            customers[index!] = obj!
            isUpdate.toggle()
            showingCustomerForm.toggle()
            statusMessage = "Editado com sucesso!"
            toggleToast()
            
            //Clean Object
            customer = Customer(name: "", phone: "", cpf: "", bornDate: Date(), gender: Genres.feminine.rawValue, createdAt: Date())
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getValue(obj: NSManagedObject) -> Customer {
        let name = obj.value(forKey: "name")
        let phone = obj.value(forKey: "phone")
        let cpf = obj.value(forKey: "cpf")
        let bordDate = obj.value(forKey: "bornDate")
        let genre = obj.value(forKey: "genre")
        let createdAt = obj.value(forKey: "createdAt")
        
        return Customer(name: name as? String, phone: phone as? String, cpf: cpf as? String, bornDate: bordDate as? Date, gender: genre as? String, createdAt: createdAt as! Date)
    }
    
    func determineUpdate(obj: NSManagedObject) {
        selectedCustomer = obj
        customer = getValue(obj: obj)
        isUpdate = true
        showingCustomerForm = true
    }
    
    func toggleToast() {
        showingToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showingToast = false
        }
    }
}
