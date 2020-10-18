//
//  UserSignUpTests.swift
//  UserSignUpTests
//
//  Created by APPLE DEVELOPER ACADEMY on 16/10/20.
//

import XCTest
@testable import UserSignUp
import CoreData

class UserSignUpTests: XCTestCase {
    
    var customer: Customer!
    var viewModel: CustomersViewModel!
    var dataStore: CoreDataStack!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        customer = Customer(name: "Joao", phone: "30000000", cpf: "000000000-90", bornDate: formatter.date(from: "1990/10/12"), gender: Genres.masculino.rawValue, createdAt: Date())
        dataStore = TestCoreDataStack()
        viewModel = CustomersViewModel(managedObjectContext: dataStore.storeContainer.viewContext, dataStore: dataStore)
        viewModel.customer = customer
        viewModel.writeData()
    }

    override func tearDownWithError() throws {
        customer = nil
        viewModel = nil
        dataStore = nil
        super.tearDown()
    }
    
    //MARK: Model Tests
    func testCalculateAge() {
        XCTAssertEqual(customer.age, 30)
    }
    
    func testGenderIsString() {
        let genderEnum = Genres(rawValue: customer.gender)
        XCTAssertTrue(genderEnum?.rawValue == customer.gender)
    }
    
    //MARK: Service/ViewModel Tests
    func testAddCustomer() {
        XCTAssertGreaterThanOrEqual(viewModel.customers.count, 0)
        XCTAssertNotNil(viewModel.customers.first(where: {$0.value(forKey: "name") as? String == customer.name}))
        XCTAssertNotNil(viewModel.customers.first(where: {$0.value(forKey: "cpf") as? String == customer.cpf}))
        XCTAssertNotNil(viewModel.customers.first(where: {$0.value(forKey: "phone") as? String == customer.phone}))
        XCTAssertNotNil(viewModel.customers.first(where: {$0.value(forKey: "bornDate") as? Date == customer.bornDate}))
        XCTAssertTrue(viewModel.customers[0].value(forKey: "name") as? String == customer.name)
    }
    
    func testGetCustomers() {
        viewModel.readData()
        
        XCTAssertNotNil(viewModel.customers)
        XCTAssertNotNil(viewModel.customers.first?.value(forKey: "id") as! UUID)
        XCTAssertTrue(viewModel.customers.count == 1)
        
    }
    
    func testUpdateCustomers() {
        viewModel.selectedCustomer = viewModel.customers.first!
        viewModel.customer.name = "Ana"
        viewModel.customer.phone = "99990000"
        viewModel.customer.cpf = "666.555.444.90"
        viewModel.updateData()
        
        XCTAssertTrue(viewModel.customers.count > 0)
        XCTAssertNotNil(viewModel.customers.first(where: {$0.value(forKey: "name") as! String == "Ana"}))
        XCTAssertNotNil(viewModel.customers.first(where: {$0.value(forKey: "phone") as! String == "99990000"}))
        XCTAssertNotNil(viewModel.customers.first(where: {$0.value(forKey: "cpf") as! String == "666.555.444.90"}))
        XCTAssertTrue(viewModel.customers.first?.value(forKey: "id") as! UUID == customer.id)
    }
    
    func testDeleteCustomer() {
        viewModel.deleteData(indexSet: IndexSet(integer: 0))
        XCTAssertNil(viewModel.customers.first)
        XCTAssertFalse(viewModel.customers.count > 0)
        XCTAssertEqual(viewModel.customers, [])
    }
    
    

}
