//
//  ContentView.swift
//  UserSignUp
//
//  Created by APPLE DEVELOPER ACADEMY on 16/10/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(selectedTab: $selectedTab).tabItem {
                Image(systemName: "house.fill")
                Text("Início")
            }.tag(0)
            CustomersView().tabItem {
                Image(systemName: "person.3.fill")
                Text("Clientes")
            }.tag(1)
            SettingsView().tabItem {
                Image(systemName: "gear")
                Text("Ajustes")
            }.tag(2)
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
