//
//  Customers.swift
//  UserSignUp
//
//  Created by APPLE DEVELOPER ACADEMY on 17/10/20.
//

import SwiftUI

//MARK: Lista de Usuários

struct CustomersView: View {
    
    @EnvironmentObject var dataModel: CustomersViewModel
    @State var showingCustomerForm: Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(dataModel.getValues(objs: dataModel.customers), id:\.id) { customer in
                    Text("\(customer.name)")
                }.onDelete(perform: dataModel.deleteData(indexSet:))
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
    
    @EnvironmentObject var dataModel: CustomersViewModel
    @Binding var showingCustomerForm: Bool
    @State private var selectedGenre: Genres = .feminine
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Nome", text: $dataModel.customer.name)
                    TextField("Telefone", text: $dataModel.customer.phone)
                    TextField("CPF", text: $dataModel.customer.cpf)
                    DatePicker("Data de Nascimento", selection: $dataModel.customer.bornDate, displayedComponents: .date)
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
                dataModel.customer.gender = selectedGenre.rawValue
                dataModel.writeData()
                //Show toast
                showingCustomerForm.toggle()
            }) {
                Text("Salvar")
            }.disabled(!checkForm()))
            
            .navigationBarTitle("Cadastro de Cliente", displayMode: .inline)
        }
    }
    
    func checkForm() -> Bool {
        if dataModel.customer.name != "" && dataModel.customer.cpf != "" && dataModel.customer.phone != "" && dataModel.customer.bornDate != nil && dataModel.customer.gender != nil {
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
