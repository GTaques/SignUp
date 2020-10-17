//
//  ButtonStyle.swift
//  UserSignUp
//
//  Created by APPLE DEVELOPER ACADEMY on 16/10/20.
//

import Foundation
import SwiftUI

public struct CustomButtonStyle: ButtonStyle {

    public func makeBody(configuration: Self.Configuration) -> some View {
            return configuration.label
                .font(.body)
                .padding()
                .background(Color.green)
                .foregroundColor(Color.white)
                .opacity(configuration.isPressed ? 0.7 : 1)
                .scaleEffect(configuration.isPressed ? 0.8 : 1)
                .animation(.easeInOut(duration: 0.2))
        }
}
