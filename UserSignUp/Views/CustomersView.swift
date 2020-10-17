//
//  Customers.swift
//  UserSignUp
//
//  Created by APPLE DEVELOPER ACADEMY on 17/10/20.
//

import SwiftUI

//MARK: Lista de Usuários

struct CustomersView: View {
    
    @State var showingCustomerForm: Bool = false
    var customers: [Customer] = [
        Customer(name: "João", phone: "30003000", cpf: "903930219", bornDate: Date(), gender: "Masculino", createdAt: Date()),
        Customer(name: "Maria", phone: "30003000", cpf: "903930219", bornDate: Date(), gender: "Feminino", createdAt: Date()),
        Customer(name: "Nicolau", phone: "30003000", cpf: "903930219", bornDate: Date(), gender: "Masculino", createdAt: Date())
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(customers, id:\.id) { customer in
                    Text("\(customer.name)")
                }.onDelete(perform: { indexSet in
                    print("Delete")
                })
            }.navigationTitle("Clientes")
            .navigationBarItems(leading: Button(action: {
                print("Edit")
            }){
                Text("Editar")
            }, trailing: Button(action: {
                showingCustomerForm.toggle()
            }){
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingCustomerForm, content: {
                CustomerFormView(showingCustomerForm: $showingCustomerForm)
            })
        }
    }
}

//MARK: Formulário de Cadastro de Usuários
struct CustomerFormView: View {
    
    
    @Binding var showingCustomerForm: Bool
    
    var body: some View {
        NavigationView {
            Text("Form")
                .navigationBarItems(leading: Button(action: {
                    showingCustomerForm.toggle()
                }) {
                    Text("Cancelar")
                }, trailing: Button(action: {
                    print("save")
                }) {
                    Text("Salvar")
                })
                .navigationBarTitle("Cadastro de Cliente", displayMode: .inline)
        }
    }
}

struct Customers_Previews: PreviewProvider {
    static var previews: some View {
        CustomersView()
    }
}
