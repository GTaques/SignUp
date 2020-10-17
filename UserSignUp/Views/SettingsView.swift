//
//  SettingsView.swift
//  UserSignUp
//
//  Created by APPLE DEVELOPER ACADEMY on 17/10/20.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Button(action: {
            print("Saindo")
        }) {
            Text("Sair do App")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
