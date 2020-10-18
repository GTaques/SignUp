//
//  SettingsView.swift
//  UserSignUp
//
//  Created by APPLE DEVELOPER ACADEMY on 17/10/20.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            Button(action: {
                print("Saindo")
            }) {
                Text("Sair do App")
            }.buttonStyle(CustomButtonStyle())
            .navigationTitle("Ajustes")
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
