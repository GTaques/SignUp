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

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                List {
                    ForEach(Array(dataModel.customers.enumerated()), id:\.element) { index, customer in
                        Text("\(dataModel.getValue(obj: customer).name) - \(dataModel.getValue(obj: customer).age)")
                            .onTapGesture {
                                dataModel.determineUpdate(obj: customer)
                            }
                    }.onDelete(perform: dataModel.deleteData(indexSet:))
                }
//                if dataModel.savedData {
//                    Text("Criado com sucesso!")
//                        .padding()
//                        .background(Color(.lightGray))
//                        .clipShape(Capsule())
//                } else {
//                    EmptyView()
//                }
                
                    
            }
            .navigationTitle("Clientes")
            .navigationBarItems(leading: Button(action: {
                print("Edit")
            }){
                Text("Editar")
            }, trailing: Button(action: {
                dataModel.showingCustomerForm.toggle()
            }){
                Image(systemName: "plus").frame(width: 30, height: 30)
            })
            .sheet(isPresented: $dataModel.showingCustomerForm, content: {
                CustomerFormView(dataModel: dataModel)
            })
        }
    }
}

//MARK: Formulário de Cadastro de Usuários
struct CustomerFormView: View {
    
    @ObservedObject var dataModel: CustomersViewModel
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
            .onAppear(perform: {
                if dataModel.isUpdate && dataModel.customer.gender != nil {
                    selectedGenre = Genres(rawValue: dataModel.customer.gender)!
                }
            })
            .navigationBarItems(leading: Button(action: {
                dataModel.showingCustomerForm.toggle()
            }) {
                Text("Cancelar")
            }, trailing: Button(action: {
                dataModel.customer.gender = selectedGenre.rawValue
                if dataModel.isUpdate {
                    dataModel.updateData()
                } else {
                    dataModel.writeData()
                }
                //Show toast
                
            }) {
                Text("Salvar")
            }.disabled(!checkForm()))
            
            .navigationBarTitle(dataModel.isUpdate ? "Cadastro de Cliente" : "Editar Cliente", displayMode: .inline)
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

//MARK: Card View

struct CustomerCardView: View {
    
    @Binding var customer: Customer
    
    var body: some View {
        Text("\(customer.name) - \(customer.age)")
    }
}

struct Customers_Previews: PreviewProvider {
    static var previews: some View {
        CustomersView()
    }
}
