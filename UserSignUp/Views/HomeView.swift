//
//  Home.swift
//  UserSignUp
//
//  Created by APPLE DEVELOPER ACADEMY on 16/10/20.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Group {
                    Button(action: {
                        print("Cadastro")
                    }) {
                        Text("Cadastrar Cliente")
                    }
                    Button(action: {
                        print("Saiu")
                    }) {
                        Text("Sair do App")
                    }
                }
                .buttonStyle(CustomButtonStyle())
                
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
