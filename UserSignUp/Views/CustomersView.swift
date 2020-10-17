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
        Customer(name: "João", phone: "30003000", cpf: "903930219", bornDate: Date(), gender: .feminine, createdAt: Date()),
        Customer(name: "Maria", phone: "30003000", cpf: "903930219", bornDate: Date(), gender: .masculino, createdAt: Date()),
        Customer(name: "Nicolau", phone: "30003000", cpf: "903930219", bornDate: Date(), gender: .feminine, createdAt: Date())
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
    
    @State var customer: Customer = Customer(name: "", phone: "", cpf: "", bornDate: Date(), gender: .feminine, createdAt: Date())
    @Binding var showingCustomerForm: Bool
    @State private var selectedGenre: Genres = .feminine
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Nome", text: $customer.name)
                    TextField("Telefone", text: $customer.phone)
                    TextField("CPF", text: $customer.cpf)
                    DatePicker("Data de Nascimento", selection: $customer.bornDate, displayedComponents: .date)
                    Text("Gênero")
                    Picker(selection: $selectedGenre, label: Text("Gênero")) {
                        ForEach(Genres.allCases, id: \.self) { genero in
                            Text(genero.rawValue).tag(genero)
                        }
                    }.frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .pickerStyle(WheelPickerStyle())
                }
                
                
                
            }
            .navigationBarItems(leading: Button(action: {
                showingCustomerForm.toggle()
            }) {
                Text("Cancelar")
            }, trailing: Button(action: {
                customer.gender = selectedGenre
                showingCustomerForm.toggle()
            }) {
                Text("Salvar")
            }.disabled(!checkForm()))
            
            .navigationBarTitle("Cadastro de Cliente", displayMode: .inline)
        }
    }
    
    func checkForm() -> Bool {
        if customer.name != "" && customer.cpf != "" && customer.phone != "" && customer.bornDate != nil && customer.gender != nil {
            return true
        } else {
            return false
        }
    }
}

struct Customers_Previews: PreviewProvider {
    static var previews: some View {
        CustomersView()
    }
}
