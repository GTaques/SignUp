//
//  Home.swift
//  UserSignUp
//
//  Created by APPLE DEVELOPER ACADEMY on 16/10/20.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        //            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)), Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))]), startPoint: .topTrailing, endPoint: .bottomLeading).edgesIgnoringSafeArea(.all)
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
            .navigationTitle("Seja bem-vinda!")
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
