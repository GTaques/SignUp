//
//  Home.swift
//  UserSignUp
//
//  Created by APPLE DEVELOPER ACADEMY on 16/10/20.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var selectedTab: Int
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    HStack(alignment: .center) {
                        Group {
                            Button(action: {
                                self.selectedTab = 1
                            }) {
                                VStack {
                                    Image("clients").resizable().aspectRatio(contentMode: .fit)
                                    Text("Cadastrar Cliente").foregroundColor(.black).font(.headline)
                                }
                                .padding()
                                
                            }
                            .frame(width: geometry.size.width / 2 - 5, height: geometry.size.height / 3)
                            .border(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), width: 2)
                            .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            Spacer()
                            Button(action: {
                                self.selectedTab = 2
                            }) {
                                VStack {
                                    Image("sair").resizable().aspectRatio(contentMode: .fit)
                                    Text("Sair do App").foregroundColor(.black).font(.headline)
                                }.padding()
                                
                            }
                            .frame(width: geometry.size.width / 2 - 5, height: geometry.size.height / 3)
                            .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            .border(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), width: 2)
                            
                        }.cornerRadius(8)
                        
                    }
                    Spacer()
                }
                
                
            }
            .padding()
            .navigationTitle("Seja bem-vinda!")
        }
    }
}

