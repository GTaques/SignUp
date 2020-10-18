//
//  UserSignUpApp.swift
//  UserSignUp
//
//  Created by APPLE DEVELOPER ACADEMY on 16/10/20.
//

import SwiftUI
import CoreData

@main
struct UserSignUpApp: App {

    @StateObject var dataModel = CustomersViewModel(dataStore: CoreDataStack())
    let context = CoreDataStack().persistentContainer.viewContext

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, context)
                .environmentObject(dataModel)
        }
    }
}
