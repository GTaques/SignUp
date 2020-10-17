//
//  Customers.swift
//  UserSignUp
//
//  Created by APPLE DEVELOPER ACADEMY on 17/10/20.
//

import SwiftUI

struct CustomersView: View {
    
    var customers: [Customer] = [
        Customer(name: "João", phone: "30003000", cpf: "903930219", bornDate: Date(), gender: "Masculino", createdAt: Date()),
        Customer(name: "Maria", phone: "30003000", cpf: "903930219", bornDate: Date(), gender: "Feminino", createdAt: Date()),
        Customer(name: "Nicolau", phone: "30003000", cpf: "903930219", bornDate: Date(), gender: "Masculino", createdAt: Date())
    ]
    
    var body: some View {
        List {
            ForEach(customers, id:\.id) { customer in
                Text("\(customer.name)")
            }
        }.navigationTitle("Clientes")
    }
}

struct Customers_Previews: PreviewProvider {
    static var previews: some View {
        CustomersView()
    }
}
