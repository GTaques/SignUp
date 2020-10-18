//
//  UserSignUpTests.swift
//  UserSignUpTests
//
//  Created by APPLE DEVELOPER ACADEMY on 16/10/20.
//

import XCTest
@testable import UserSignUp

class UserSignUpTests: XCTestCase {
    
    var customer: Customer!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        customer = Customer(name: "Joao", phone: "30000000", cpf: "000000000-90", bornDate: formatter.date(from: "1990/10/12"), gender: Genres.masculino.rawValue, createdAt: Date())
    }

    override func tearDownWithError() throws {
        customer = nil
        super.tearDown()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //MARK: Model Tests
    func testCalculateAge() {
        XCTAssertEqual(customer.age, 30)
    }
    
    func testGenderIsString() {
        let genderEnum = Genres(rawValue: customer.gender)
        XCTAssertTrue(genderEnum?.rawValue == customer.gender)
    }

}
